`timescale 1ns/1ns

module d_ff_reset_en_tb;
    reg clk;
    reg reset;

    wire [7:0] q;
    wire max_tick;  

binary_counter circuit1 (clk, reset, q, max_tick);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, binary_counter);

    clk <= 0;
    reset <= 1;
    #20;

    reset <= 0;
    #20;

    #20;

    #20;

    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, q = %b max_tick = %b", clk, reset, q, max_tick);
end


endmodule