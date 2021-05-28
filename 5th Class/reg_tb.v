`timescale 1ns/1ns

module register_tb;
    reg clk;
    reg reset;
    reg [7:0] d;
    wire [7:0] q;

register circuit1 (clk, reset, d, q);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, register_tb);

    clk <= 0;
    reset <= 1;
    d <= 8'b0000_0000;
    #20;

    reset <= 0;
    d <= 8'b0000_1111;
    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, d = %b, q = %b", clk, reset, d, q);
end


endmodule