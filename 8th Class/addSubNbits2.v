module addSubNbits2 
# (parameter N = 4)
(
    input wire [N:0] x,
    input wire [N:0] y,
    input sel,
    output reg [N+1:0] z
);

always @(*) 
begin
    if (sel==0) 
        z = {1'b0, x} + {1'b0, y};
    else
        z = {1'b0, x} - {1'b0, y};        
end

always @(*)
begin
    case(sel)
        1'b0: z = {1'b0, x} + {1'b0, y};
        1'b1: z = {1'b0, x} - {1'b0, y};
        default: z = 0; 
    endcase
end

endmodule