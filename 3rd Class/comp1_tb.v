`timescale 1ns/1ps

module comp1_tb;
reg x;
reg y;
wire z;

comp1 circuit1 (.i0(x),.i1(y),.out(z));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, comp1_tb);
    x = 0;
    y = 0;
    #20;
    x = 1;
    #20;
    y = 1;
    #20;
    x = 0;
    #40;
end

initial begin
    $monitor("x=%d, y=%d, z=%d", x, y, z);
end

endmodule