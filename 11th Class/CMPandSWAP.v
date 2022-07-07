module CMPandSWAP
#(
    parameter ADDR_WIDTH = 2, //log2(4)
              DATA_WIDTH = 8
)
(
    input wire clk, reset,
    input wire start,
    input wire [ADDR_WIDTH:0] i,
    input wire [DATA_WIDTH-1:0] read_data_1, 
    input wire [DATA_WIDTH-1:0] read_data_2, 

    output wire [DATA_WIDTH-1:0] write_data, 
    output wire [ADDR_WIDTH:0] read_addr_1,
    output wire [ADDR_WIDTH:0] read_addr_2,
    output wire [ADDR_WIDTH:0] write_addr,
    output wire we,
    output wire finish
);

localparam [2:0] Idle           = 3'b000,
                 Compare        = 3'b001,
                 Swap1          = 3'b010,
                 Swap2          = 3'b011,
                 Done           = 3'b100,
                 Error          = 3'b101;

reg [3:0] state_reg, state_next;
reg [DATA_WIDTH:0] data1_reg, data1_next;
reg [DATA_WIDTH:0] data2_reg, data2_next;
reg [ADDR_WIDTH:0] data1_addr_reg, data1_addr_next;
reg [ADDR_WIDTH:0] data2_addr_reg, data2_addr_next;
reg [DATA_WIDTH:0] write_data_reg, write_data_next;
reg [ADDR_WIDTH:0] write_addr_reg, write_addr_next;
reg [ADDR_WIDTH:0] we_reg, we_next;


//Memory
always @(posedge clk, posedge reset)
    if(reset)
    begin
        state_reg <= Idle;
        data1_reg <= 0;
        data2_reg <= 0;
        data1_addr_reg <= 0;
        data2_addr_reg <= 0;
        write_data_reg <= 0;
        write_addr_reg <= 0;
        we_reg <= 0;
    end
    else
    begin
        state_reg <= state_next;
        data1_reg <= data1_next;
        data2_reg <= data2_next;
        data1_addr_reg <= data1_addr_next;
        data2_addr_reg <= data2_addr_next;
        write_data_reg <= write_data_next;
        write_addr_reg <= write_addr_next;
        we_reg <= we_next;
    end

//Next State Logic
always@(*)
begin
    // if(state_reg==Idle)
    //     $monitor("state_reg = Idle -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    // else if(state_reg==Compare)
    //     $monitor("state_reg = Compare -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    // else if(state_reg==Swap1)
    //     $monitor("state_reg = Swap1 -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    // else if(state_reg==Swap2)
    //     $monitor("state_reg = Swap2 -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    // else if(state_reg==Done)
    //     $monitor("state_reg = Done -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
    // else if(state_reg==Error)
    //     $monitor("state_reg = Error -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);

    state_next = state_reg;
    data1_next = data1_reg;
    data2_next = data2_reg;
    data1_addr_next = data1_addr_reg;
    data2_addr_next = data2_addr_reg;
    write_data_next = write_data_reg;
    write_addr_next = write_addr_reg;
    we_next = we_reg;

    case(state_reg)
        Idle: 
            if(start)
                begin
                    $display("   ######IDLE -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
                    data1_addr_next = i;
                    data2_addr_next = i+1;
                    state_next = Compare;
                end
        Compare:
            begin
                $display("   ######COMPARE -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
                data1_next = read_data_1;
                data2_next = read_data_2;
                if(read_data_1>read_data_2)
                    state_next = Swap1;
                else
                    state_next = Done;
            end
        Swap1:
            begin
                $display("   ######SWAP1 -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
                we_next = 1;
                write_addr_next = i+1;
                write_data_next = data1_reg;
                state_next = Swap2;
            end
        Swap2:
            begin
                $display("   ######SWAP2 -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
                we_next = 1;
                write_addr_next = i;
                write_data_next = data2_reg;
                state_next = Done;
            end
        Done: 
            begin
                $display("   ######DONE -> clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
                we_next = 0;
                state_next = Idle;
            end
        default: state_next = Error;
    endcase
end

assign finish = (state_reg==Done) ? 1 : 0;
assign read_addr_1 = data1_addr_reg;
assign read_addr_2 = data2_addr_reg;
assign write_addr = write_addr_reg;
assign write_data = write_data_reg;
assign we = we_reg;

endmodule