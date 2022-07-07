module dualPortRAM 
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8
)
(
    input wire clk,
    input wire we,
    input wire [ADDR_WIDTH-1:0] read_addr_1,
    input wire [ADDR_WIDTH-1:0] read_addr_2,
    input wire [ADDR_WIDTH-1:0] write_addr,
    input wire [DATA_WIDTH-1:0] write_data,
    output wire [DATA_WIDTH-1:0] read_data_1,
    output wire [DATA_WIDTH-1:0] read_data_2
);

integer idx;
reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

initial begin
    $dumpfile("test.vcd");
    for (idx = 0; idx < 2**ADDR_WIDTH; idx = idx + 1) $dumpvars(0, ram[idx]);
end

always @(posedge clk) 
begin
    if(we)
    begin
        ram[write_addr] <= write_data;
        $display("   ==>clk = %b, RAM[0] = %d, RAM[1] = %d, RAM[2] = %d, RAM[3] = %d\n   ==>we=%b, write_addr=%d, write_data=%d\n", clk, ram[0], ram[1], ram[2], ram[3], we, write_addr, write_data);
    end
end

assign read_data_1 = ram[read_addr_1];
assign read_data_2 = ram[read_addr_2];

endmodule