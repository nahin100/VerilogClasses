`timescale 1ns/1ps

module comp_tb;
reg x;
reg y;
wire z;

and_gate circuit1 (.x(x),.y(y),.z(z));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, and_gate_tb);
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
