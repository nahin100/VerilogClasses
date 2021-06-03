`timescale 1ns/1ns

module fsm_ex1_type1_tb;
    reg clk;
    reg reset;

    reg a;
    reg b;

    wire y0;
    wire y1;

fsm_ex1_type1 circuit1 (clk, reset, a, b, y0, y1);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, fsm_ex1_type1_tb);

    clk <= 0;
    reset <= 1;
    #20;

    reset <= 0;
    a <= 1;
    b <= 0;
    #20;

    a <= 1;
    b <= 0;
    #20;

    a <= 1;
    b <= 1;
    #20;

    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, a = %b, b = %b, y0 = %b, y1 = %b", clk, reset, a, b, y0, y1);
end


endmodule


// VCD info: dumpfile test.vcd opened for output.  
// clk = 0, reset = 1, a = x, b = x, y0 = x, y1 = 1 #s0
// clk = 1, reset = 1, a = x, b = x, y0 = x, y1 = 1 #s0

// clk = 0, reset = 0, a = 1, b = 0, y0 = 0, y1 = 1 #s0
// clk = 1, reset = 0, a = 1, b = 0, y0 = 0, y1 = 1 #s1

// clk = 0, reset = 0, a = 1, b = 0, y0 = 0, y1 = 1 #s1
// clk = 1, reset = 0, a = 1, b = 0, y0 = 0, y1 = 1 #s0

// clk = 0, reset = 0, a = 1, b = 1, [y0 = 1], y1 = 1 #s0
// clk = 1, reset = 0, a = 1, b = 1, y0 = 0, y1 = 0 #s2

// clk = 0, reset = 0, a = 1, b = 1, y0 = 0, y1 = 0 #s2
// clk = 1, reset = 0, a = 1, b = 1, y0 = 1, y1 = 1 #s0

// fsm_ex1_type1_tb.v:43: $finish called at 100 (1ns)
// clk = 0, reset = 0, a = 1, b = 1, y0 = 1, y1 = 1
// # gtkwave test.vcd &