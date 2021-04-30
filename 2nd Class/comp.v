module comp
(
    input wire x,
    input wire y,
    output wire z
);

assign z = (~x)&(~y) | x&y;

endmodule





