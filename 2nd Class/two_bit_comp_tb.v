`timescale 1ns/1ps

module two_bit_comp_tb;
reg [1:0] x;
reg [1:0] y;
wire answer;

two_bit_comp2 circuit1 (x, y, answer);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, two_bit_comp_tb);
    x = 2'b00;
    y = 2'b00;
    #20;
    x = 2'b00;
    y = 2'b01;
    #20;
    x = 2'b01;
    y = 2'b00;
    #20;
    x = 2'b11;
    y = 2'b11;
    #40;
end

initial begin
    $monitor("x=%d, y=%d, z=%d", x, y, answer);
end

endmodule
