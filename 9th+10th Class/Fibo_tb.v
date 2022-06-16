`timescale 1ns/1ps

module Fibo_tb
();
reg clk;
reg reset;
reg start;
reg [4:0] i;
wire finish;
wire [19:0] result;

Fibo circuit1(
            .clk(clk), 
            .reset(reset), 
            .start(start), 
            .i(i), 
            .finish(finish),
            .result(result)
            );

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, Fibo_tb);

    clk <= 0;
    reset <= 1;
    start <= 0;
    i <= 0;
    #20;

    reset <= 0;
    start <= 1;
    i <= 5;
    #20;

    #200;

    $finish;
end

// initial begin
//     $monitor("clk = %b, reset = %b, a = %b, b = %b | y0 = %b, y1 = %b\n", clk, reset, a, b, y0, y1);
// end



endmodule