module add_circuit2
(
    input wire [7:0] x,
    input wire [7:0] y,
    output wire [7:0] z,
    output wire cout
);

localparam N = 8, N1 = N-1;

wire [N:0] temp;
assign temp = {1'b0,x} + {1'b0,y};

assign z = temp[N1:0];
assign cout = temp[N];

endmodule