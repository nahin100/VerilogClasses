`timescale 1ns/1ns

module stopwatch_tb;
    reg clk;
    reg reset;

    // output wire [22:0] ms_output;
    wire [3:0] d;
    wire max_tick;  

// stopwatch circuit1 (clk, reset, ms_output, d, max_tick);
stopwatch circuit1 (clk, reset, d, max_tick);

// wire [3:0] ms_output_truncate;
// assign ms_output_truncate = ms_output[3:0];
// wire [1:0] d_truncate;
// assign d_truncate = d[1:0];


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

    #20;
    #20;

    #20;
    #20;


    $finish;
end

initial begin
    // $monitor("clk = %b, reset = %b, ms_output = %4b, d = %b max_tick = %b", clk, reset, ms_output_truncate, d, max_tick);
    $monitor("clk = %b, reset = %b, d = %b max_tick = %b", clk, reset, d, max_tick);
end


endmodule