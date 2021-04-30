module add_circuit3
# (parameter N = 3)
(
    input wire [N:0] x,
    input wire [N:0] y,
    output wire [N+1:0] z
//    output wire cout
);

localparam N1 = N-1;

wire [N:0] temp;
assign temp = {1'b0,x} + {1'b0,y};

assign z = temp;
//assign z = temp[N1:0];
//assign cout = temp[N];

endmodule