module addNbits 
# (parameter N = 32)
(
    input wire [N:0] x,
    input wire [N:0] y,
    input cin,
    output wire [N:0] z,
    output wire cout
);

wire [N+1:0] temp;

assign temp = {1'b0, x} + {1'b0, y} + cin;

assign z = temp[N:0];
assign cout = temp[N+1];

endmodule