module regNbits_2seg
# ( parameter N = 4) 
(
    input wire clk,
    input wire reset,
    input wire en,
    input wire [N-1:0] d,
    output reg [N-1:0] q
);

//Memory
reg [N-1:0] r_reg, r_next;

always @(posedge clk, posedge reset) 
begin
    if(reset)
        r_reg <= 0;
    else
        r_reg <= r_next;
end


//Next State Logic
always @(*) 
begin
    if(en)
        r_next = d;
    else
        r_next = r_reg;
end


//Output Logic
always @(*) 
begin
    q = r_reg;
end

endmodule