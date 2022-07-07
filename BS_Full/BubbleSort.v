module BubbleSort
#(
    parameter SIZE = 4,
              ADDR_WIDTH = 2, //log2(4)
              DATA_WIDTH = 8
)
(
    input wire clk, reset,
    input wire start,
    output reg finish
);

localparam [3:0] Idle           = 4'b0000,
                 ROM2RAM        = 4'b0001,
                 OuterLoopStart = 4'b0010,
                 InnerLoopStart = 4'b0011,
                 InnerLoopEnd   = 4'b0100,
                 OuterLoopEnd   = 4'b0101,
                 Done           = 4'b0110,
                 Error          = 4'b0111;

reg [3:0] state_reg, state_next;
reg [ADDR_WIDTH:0] ROM2RAM_counter_reg, ROM2RAM_counter_next;
reg [ADDR_WIDTH:0] j_reg, j_next;
reg [ADDR_WIDTH:0] i_reg, i_next;


wire RAM_we;
wire [ADDR_WIDTH-1:0] RAM_read_addr_1, RAM_read_addr_2, RAM_write_addr, ROM_read_addr;
wire [DATA_WIDTH-1:0] RAM_read_data_1, RAM_read_data_2, RAM_write_data, ROM_read_data;

reg CMPandSWAP_start;
wire CMPandSWAP_we, CMPandSWAP_finish;
wire [ADDR_WIDTH:0] CMPandSWAP_read_addr_1, CMPandSWAP_read_addr_2, CMPandSWAP_write_addr, CMPandSWAP_i;
wire [DATA_WIDTH-1:0] CMPandSWAP_read_data_1, CMPandSWAP_read_data_2, CMPandSWAP_write_data;

//Component Instantiation
dualPortRAM #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) 
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

ROM #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
ROMcircuit 
(
    .read_addr(ROM_read_addr),
    .read_data(ROM_read_data)
);

CMPandSWAP #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
CMPandSWAPcircuit
(
    .clk(clk), 
    .reset(reset),
    .start(CMPandSWAP_start),
    .i(CMPandSWAP_i),
    .read_data_1(CMPandSWAP_read_data_1), 
    .read_data_2(CMPandSWAP_read_data_2), 
    .write_data(CMPandSWAP_write_data), 
    .read_addr_1(CMPandSWAP_read_addr_1),
    .read_addr_2(CMPandSWAP_read_addr_2),
    .write_addr(CMPandSWAP_write_addr),
    .we(CMPandSWAP_we),
    .finish(CMPandSWAP_finish)
);

//Memory
always @(posedge clk, posedge reset)
    if(reset)
    begin
        state_reg <= Idle;
        ROM2RAM_counter_reg <= 0;
        j_reg <= 0;
        i_reg <= 0;
    end
    else
    begin
        state_reg <= state_next;
        ROM2RAM_counter_reg <= ROM2RAM_counter_next;
        j_reg <= j_next;
        i_reg <= i_next;
    end

//Next State Logic
always@(*)
begin
    if(state_reg==Idle)
        $monitor("state_reg = Idle -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==ROM2RAM)
        $monitor("state_reg = ROM2RAM -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==OuterLoopStart)
        $monitor("state_reg = OuterLoopStart -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==InnerLoopStart)
        $monitor("state_reg = InnerLoopStart -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==InnerLoopEnd)
        $monitor("state_reg = InnerLoopEnd -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==OuterLoopEnd)
        $monitor("state_reg = OuterLoopEnd -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==Done)
        $monitor("state_reg = Done -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);
    else if(state_reg==Error)
        $monitor("state_reg = Error -> clk = %b, reset = %b, start = %b, finish = %b\n************************************\n", clk, reset, start, finish);

    // if(state_reg==Idle)
    //     $monitor("state_reg = Idle -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==ROM2RAM)
    //     $monitor("state_reg = ROM2RAM -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==OuterLoopStart)
    //     $monitor("state_reg = OuterLoopStart -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==InnerLoopStart)
    //     $monitor("state_reg = InnerLoopStart -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==InnerLoopEnd)
    //     $monitor("state_reg = InnerLoopEnd -> reset = %b, start = %b, finish = %b\n\n", reset, start, finish);
    // else if(state_reg==OuterLoopEnd)
    //     $monitor("state_reg = OuterLoopEnd -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==Done)
    //     $monitor("state_reg = Done -> reset = %b, start = %b, finish = %b\n", reset, start, finish);
    // else if(state_reg==Error)
    //     $monitor("state_reg = Error -> reset = %b, start = %b, finish = %b\n", reset, start, finish);

    state_next = state_reg;
    ROM2RAM_counter_next = ROM2RAM_counter_reg;
    j_next = j_reg;
    i_next = i_reg;

    finish = 'b0;
    CMPandSWAP_start = 'b0;

    case(state_reg)
        Idle: 
            if(start)
                begin
                    ROM2RAM_counter_next = SIZE-1;
                    state_next = ROM2RAM;
                end
        ROM2RAM:
            begin
                $display("   ==>ROM2RAM_counter_reg = %d\n", ROM2RAM_counter_reg);
                if(ROM2RAM_counter_reg > 0)
                    ROM2RAM_counter_next = ROM2RAM_counter_reg-1;
                else
                    begin
                        state_next = OuterLoopStart;
                        j_next = 0;
                    end
            end
        OuterLoopStart:
            begin
                $display("   ==>J_reg = %d\n", j_reg);

                if(j_reg < SIZE - 1)
                begin
                    i_next = 0;
                    state_next = InnerLoopStart;
                end
                else
                    state_next = Done;
            end
        InnerLoopStart:
            begin
                $display("   ==>I_reg = %d\n", i_reg);

                if(i_reg < SIZE - j_reg - 1)
                begin
                    CMPandSWAP_start = 1'b1;
                    state_next = InnerLoopEnd;
                end
                else
                    state_next = OuterLoopEnd;

            end
        InnerLoopEnd:
        begin
            if(CMPandSWAP_finish)
            begin
                i_next = i_reg + 1;
                state_next = InnerLoopStart;
            end
        end
        OuterLoopEnd:
        begin
            j_next = j_reg + 1;
            state_next = OuterLoopStart;
        end
        Done: 
            begin
                finish = 'b1;
                state_next = Idle;
            end
        default: state_next = Error;
    endcase
end

assign RAM_we = (state_reg==ROM2RAM) ? 1 : 
                (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? CMPandSWAP_we :
                0;
assign RAM_read_addr_1 = (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? CMPandSWAP_read_addr_1 : 0;
assign RAM_read_addr_2 = (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? CMPandSWAP_read_addr_2 : 0;
assign RAM_write_addr = (state_reg==ROM2RAM) ? ROM2RAM_counter_reg : 
                        (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? CMPandSWAP_write_addr :
                        0;
assign RAM_write_data = (state_reg==ROM2RAM) ? ROM_read_data :
                        (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? CMPandSWAP_write_data :
                        0;

assign ROM_read_addr = (state_reg==ROM2RAM) ? ROM2RAM_counter_reg : 0;

assign CMPandSWAP_i = (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? i_reg : 0;
assign CMPandSWAP_read_data_1 = (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? RAM_read_data_1 : 0;
assign CMPandSWAP_read_data_2 = (state_reg==InnerLoopStart || state_reg==InnerLoopEnd) ? RAM_read_data_2 : 0;  

endmodule