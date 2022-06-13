module regNbits
# ( parameter N = 4) 
(
    input wire clk,
    input wire reset,
    input wire en,
    input wire [N-1:0] d,
    output reg [N-1:0] q
);

always @(posedge clk, posedge reset) 
begin
    if(reset)
        q <= 0;
    else if(en)
        q <= d;
end

endmodule