`timescale 1ns/1ps

module addNbits_tb();
localparam N = 32;

reg [N:0] x;
reg [N:0] y;
reg cin;
wire [N:0] z;
wire cout;

addNbits circuit1(.x(x), .y(y), .cin(cin), .z(z), .cout(cout));

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, addNbits_tb);

    x = 'd2;
    y = 'd2;
    cin = 1'd0;
    #20;

    x = 'd255;
    y = 'd255;
    cin = 1'd0;
    #20;

    $stop;
end

initial begin
    $monitor("x = %b y = %b cin = %b cout = %b z = %b", x, y, cin, cout, z);
end



endmodule