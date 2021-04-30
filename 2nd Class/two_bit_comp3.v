module two_bit_comp2
(
    input wire [1:0] x, y,
    output wire answer
);

assign answer = x == y;


endmodule