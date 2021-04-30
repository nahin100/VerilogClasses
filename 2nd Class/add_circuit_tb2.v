`timescale 1ns/1ps

module add_circuit_tb2;
reg [7:0] x;
reg [7:0] y;
wire [7:0] z;
wire cout;

add_circuit2 circuit1 (.x(x),.y(y), .z(z), .cout(cout));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, add_circuit_tb2);
    x = 8'd2;
    y = 8'd2;
    #20;
    x = 8'd255;
    y = 8'd255;
    #20;

    $stop;
end

initial begin
    $monitor("x=%d, y=%d, cout=%d, z=%d", x, y, cout, z);
end

endmodule
