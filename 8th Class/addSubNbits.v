module addSubNbits 
# (parameter N = 4)
(
    input wire [N:0] x,
    input wire [N:0] y,
    input sel,
    output wire [N+1:0] z
);

assign z = (sel==0) ? {1'b0, x} + {1'b0, y} : {1'b0, x} - {1'b0, y} ;

endmodule