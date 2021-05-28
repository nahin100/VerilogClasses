module register (
    input wire clk,
    input wire reset,
    input wire [7:0] d,
    output reg [7:0] q
);

always @(posedge clk, posedge reset) 
begin
    if (reset)
        q <= 8'b0000_0000;
    else
        q <= d;   
end
    
endmodule