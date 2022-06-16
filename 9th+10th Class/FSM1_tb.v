`timescale 1ns/1ps

module FSM1_tb
();
reg clk;
reg reset;
reg a;
reg b;
wire y0;
wire y1;

FSM1 circuit1(
            .clk(clk), 
            .reset(reset), 
            .a(a), 
            .b(b), 
            .y0(y0),
            .y1(y1)
            );

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, FSM1_tb);

    clk <= 0;
    reset <= 1;
    a <= 0;
    b <= 0;
    #20;

    reset <= 0;
    a <= 0;
    b <= 0;
    #20;

    reset <= 0;
    a <= 1;
    b <= 1;
    #20;

    reset <= 0;
    a <= 1;
    b <= 0;
    #20;


    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, a = %b, b = %b | y0 = %b, y1 = %b\n", clk, reset, a, b, y0, y1);
end



endmodule