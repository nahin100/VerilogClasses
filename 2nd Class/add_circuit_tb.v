`timescale 1ns/1ps

module add_circuit_tb;
reg x;
reg y;
reg cin;
wire z;
wire cout;

add_circuit circuit1 (.x(x),.y(y),.cin(cin),.z(z), .cout(cout));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, add_circuit_tb);
    x = 0;
    y = 0;
    cin = 0;
    #20;
    x = 1;
    #20;
    y = 1;
    #20;
    cin = 1;
    #40;
end

initial begin
    $monitor("x=%d, y=%d, cin=%d, cout=%d, z=%d", x, y, cin, cout, z);
end

endmodule
