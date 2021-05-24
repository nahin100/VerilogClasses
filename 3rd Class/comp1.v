module comp1
(
    input wire i0, 
    input wire i1,
    output reg out
);

reg p0, p1;

always @(i0,i1) 
begin
    p0 = ~i0 & ~i1;
    p1 = i0 & i1;
    out = p0 | p1;    
end

endmodule