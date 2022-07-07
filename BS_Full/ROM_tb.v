`timescale 1ns/1ps

module ROM_tb
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8
)
();
reg [ADDR_WIDTH-1:0] read_addr;
wire [DATA_WIDTH-1:0] read_data;

ROM circuit1
(
    .read_addr(read_addr), 
    .read_data(read_data)
);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, ROM_tb);

    read_addr <= 0;
    #20;
    read_addr <= 1;
    #20;
    read_addr <= 50;
    #20;

    $finish;
end

initial begin
    $monitor("read_addr = %b | read_data = %b", read_addr, read_data);
end



endmodule