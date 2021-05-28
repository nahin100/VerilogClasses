`timescale 1ns/1ns

module d_ff_reset_tb;
    reg clk;
    reg reset;
    reg d;
    wire q;

d_ff_reset circuit1 (clk, reset, d, q);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, d_ff_reset_tb);

    clk <= 0;
    reset <= 1;
    d <= 0;
    #20;

    reset <= 0;
    d <= 1;
    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, d = %b, q = %b", clk, reset, d, q);
end


endmodule