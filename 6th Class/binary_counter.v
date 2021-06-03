module binary_counter 
(
    input wire clk, reset,
    output reg [7:0] q,
    output reg max_tick    
);

reg [7:0] r_next;
reg [7:0] r_reg;

//memory/register/d_ff
always @(posedge clk, posedge reset) 
begin
    if (reset)
        r_reg <= 8'b0000_0000;
    else
        r_reg <= r_next;   
end

//next state logic
// assign r_next = r_reg + 1;
always @(*) 
begin
    r_next = r_reg + 1;    
end

//output logic
// assign q = r_reg;
// assign max_tick = (r_reg==8'b1111_1111) ? 1'b1 : 1'b0;

always @(*) 
begin
    q = r_reg;

    if (r_reg==8'b1111_1111) 
        begin
            max_tick = 1'b1;    
        end
    else
        begin
            max_tick = 1'b0;            
        end
end

endmodule