`timescale 1ns/1ps

module dualPortRAM_tb
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8
)
();
reg clk;
reg we;
reg [ADDR_WIDTH-1:0] read_addr_1;
reg [ADDR_WIDTH-1:0] read_addr_2;
reg [ADDR_WIDTH-1:0] write_addr;
reg [DATA_WIDTH-1:0] write_data;
wire [DATA_WIDTH-1:0] read_data_1;
wire [DATA_WIDTH-1:0] read_data_2;

dualPortRAM circuit1
(
    .clk(clk), 
    .we(we), 
    .read_addr_1(read_addr_1), 
    .read_addr_2(read_addr_2), 
    .write_addr(write_addr), 
    .write_data(write_data),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2)
);

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, dualPortRAM_tb);

    clk <= 0;
    we <= 0;
    read_addr_1 <= 0;
    read_addr_2 <= 1;
    write_addr <= 0;
    write_data <= 1;
    #20;

    we <= 1;
    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, we = %b, read_addr_1 = %b, read_addr_2 = %b, write_addr = %b, write_data = %b \n | read_data_1 = %b, read_data_2 = %b", clk, we, read_addr_1, read_addr_2, write_addr, write_data, read_data_1, read_data_2);
end



endmodule