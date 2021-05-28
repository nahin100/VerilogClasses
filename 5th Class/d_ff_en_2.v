module d_ff_reset_en (
    input wire clk,
    input wire reset,
    input wire en,
    input wire d,
    output reg q
);

reg r_next, r_reg;

//memory/register/d_ff
always @(posedge clk, posedge reset) 
begin
    if (reset)
        r_reg <= 1'b0;
    else
        r_reg <= r_next;   
end

//next state logic
always @(*) 
begin
    if (en)
        r_next = d;
    else
        r_next = r_reg;    
end

//output logic
always @(*) begin
    q = r_reg;
end

endmodule