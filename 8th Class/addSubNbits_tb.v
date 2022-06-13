`timescale 1ns/1ps

module addSubNbits_tb();
localparam N = 4;

reg [N:0] x;
reg [N:0] y;
reg sel;
wire [N+1:0] z;

addSubNbits circuit1(.x(x), .y(y), .sel(sel), .z(z));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, addSubNbits_tb);

    x = 'd2;
    y = 'd2;
    sel = 'd0;
    #20;

    x = 'd0;
    y = 'd2;
    sel = 'd1;
    #20;

    $stop;
end

initial begin
    $monitor("x = %b y = %b sel = %b | z = %b", x, y, sel, z);
end



endmodule