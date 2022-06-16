`timescale 1ns/1ps

module regNbits_tb
();
reg clk;
reg reset;
reg en;
reg [N-1:0] d;
wire [N-1:0] q;

regNbits circuit1(.clk(clk), .reset(reset), .en(en), .d(d), .q(q));

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, regNbits_tb);

    clk <= 0;
    reset <= 1;
    en <= 0;
    d <= 0;
    #20;

    reset <= 0;
    en <= 1;
    d <= 1;
    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, en = %b, d = %b | q = %b", clk, reset, en, d, q);
end



endmodule