module BS 
#(
    parameter ADDR_WIDTH = 2,
              DATA_WIDTH = 8          
) 
(
    input wire clk,
    input wire reset,
    input wire start,
    output reg finish
);

parameter SIZE = 2**ADDR_WIDTH;

localparam [3:0] Idle    = 4'b0000,
                 ROM2RAM = 4'b0001,
                 Done    = 4'b0010,
                 Error   = 4'b0011;

reg [3:0] state_reg, state_next;
reg [ADDR_WIDTH:0] addr_reg, addr_next;

//Component Instatiation
wire RAM_we;
wire [ADDR_WIDTH-1:0] RAM_read_addr_1, RAM_read_addr_2, RAM_write_addr;
wire [DATA_WIDTH-1:0] RAM_read_data_1, RAM_read_data_2, RAM_write_data;

dualPortRAM #(.ADDR_WIDTH(2), .DATA_WIDTH(8)) 
RAMcircuit
(
    .clk(clk),
    .we(RAM_we),
    .read_addr_1(RAM_read_addr_1),
    .read_addr_2(RAM_read_addr_2),
    .write_addr(RAM_write_addr),
    .write_data(RAM_write_data),
    .read_data_1(RAM_read_data_1),
    .read_data_2(RAM_read_data_2)
);

wire [ADDR_WIDTH-1:0] ROM_read_addr;
wire [DATA_WIDTH-1:0] ROM_read_data;
ROM #(.ADDR_WIDTH(2), .DATA_WIDTH(8)) 
ROMcircuit
(
    .read_addr(ROM_read_addr),
    .read_data(ROM_read_data)    
);

//Memory
always @(posedge clk, posedge reset) 
begin
    if(reset)
        begin
            state_reg <= Idle;
            addr_reg <= 0;
        end
    else
        begin
            state_reg <= state_next;
            addr_reg <= addr_next;
        end
end


//FSM
always@(*)
begin
    if(state_reg==Idle)
        $monitor("state_reg = IDLE, clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    else if(state_reg==ROM2RAM)
        $monitor("state_reg = ROM2RAM, clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    else if(state_reg==Done)
        $monitor("state_reg = Done, clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    else if(state_reg==Error)
        $monitor("state_reg = Error, clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);

    state_next = state_reg;
    addr_next = addr_reg;
    finish = 1'b0;

    case(state_reg)
        Idle:
            if(start)
            begin
                state_next = ROM2RAM;
                addr_next = 0;
            end
        ROM2RAM:
            begin
                $display("   ==>(ROM2RAM) ==> addr_reg = %d\n", addr_reg);
                if(addr_reg < SIZE)
                begin
                    addr_next = addr_reg + 1;
                end
                else
                begin
                    state_next = Done;
                end
            end
        Done:
            begin
                finish = 1'b1;
                state_next = Idle;
            end
        default: state_next = Error;
    endcase
end

assign RAM_we = (state_reg==ROM2RAM) ? 1 : 0;
assign RAM_read_addr_1 = 0;
assign RAM_read_addr_2 = 0; 
assign RAM_write_addr = (state_reg==ROM2RAM) ? addr_reg : 0;
assign RAM_write_data = (state_reg==ROM2RAM) ? ROM_read_data : 0;

assign ROM_read_addr = (state_reg==ROM2RAM) ? addr_reg : 0;

endmodule