`timescale 1ns/1ns

module universal_shift_register_tb;
    reg clk;
    reg reset;
    reg [1:0] ctrl;
    reg [7:0] d;

    wire [7:0] q;

universal_shift_register circuit1 (clk, reset, ctrl, d, q);

always begin
    clk = ~clk;
    #10;
end

initial begin
   $dumpfile("test.vcd");
   $dumpvars(0, universal_shift_register_tb);

    clk <= 0;
    reset <= 1;
    ctrl <= 2'b11;
    d <= 8'b0000_0000;
    #20;

    reset <= 0;
    ctrl <= 2'b11;
    d <= 8'b1111_0110;
    #20;

    ctrl <= 2'b01;
    #20;

    ctrl <= 2'b10;
    #20;

    #20;

    $finish;
end

initial begin
    $monitor("clk = %b, reset = %b, ctrl = %2b d = %8b  q = %8b", clk, reset, ctrl, d, q);
end


endmodule