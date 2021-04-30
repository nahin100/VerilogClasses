`timescale 1ns/1ps

module add_circuit_tb3;
localparam N = 32;
reg [N:0] x;
reg [N:0] y;
wire [N:0] z;

add_circuit3 #(.N(N)) circuit1 (.x(x),.y(y), .z(z));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, add_circuit_tb3);
    x = 32'd512;
    y = 32'd512;
    #20;

    $stop;
end

initial begin
    $monitor("x=%d, y=%d, z=%d", x, y, z);
end

endmodule
