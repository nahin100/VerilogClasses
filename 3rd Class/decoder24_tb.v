`timescale 1ns/1ps

module decoder24_tb;
reg [1:0] a;
reg en;
wire [3:0] y;

decoder24 circuit1 (a, en, y);

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, decoder24_tb);
    a = 2'b00;
    en = 1;
    #20;
    a = 2'b01;
    #20;
    a = 2'b10;
    #20;
    a = 2'b11;
    #40;
end

initial begin
    $monitor("x=%d, y=%d, z=%d", a, en, y);
end

endmodule