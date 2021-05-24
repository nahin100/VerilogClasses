`timescale 1ns/1ps

module barrel_shifter_tb;
reg [7:0] a;
reg [2:0] amt;
wire [7:0] y;

barrel_shifter circuit1 (a, amt, y);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, barrel_shifter_tb);
    a = 8'b0000_1111;
    amt = 3'd1;
    #20;
    amt = 3'd2;
    #20;
    amt = 3'd3;
    #20;
    amt = 3'd4;
    #40;
end

initial begin
    $monitor("x=%8b, y=%3b, z=%8b", a, amt, y);
end

endmodule