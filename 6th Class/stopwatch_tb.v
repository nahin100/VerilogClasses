`timescale 1ns/1ns

module stopwatch_tb;
    reg clk;
    reg reset;

    wire [3:0] d;
    wire max_tick;  

stopwatch circuit1 (clk, reset, d, max_tick);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, stopwatch_tb);

    clk <= 0;
    reset <= 1;
    #20;

    reset <= 0;
    #20;
    #20;
    #20;

    #20;
    #20;

    #20;
    #20;

    #20;
    #20;

    #20;
    #20;

    #20;
    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, d = %b max_tick = %b", clk, reset, d, max_tick);
end


endmodule