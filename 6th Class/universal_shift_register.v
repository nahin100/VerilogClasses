module universal_shift_register 
(
    input wire clk, reset,
    input wire [1:0] ctrl,
    input wire [7:0] d,
    output wire [7:0] q
);

//control logic 2bit
// 00 -> no operation
// 01 -> left shift
// 10 -> right shift
// 11 -> load data

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
always @(*) 
begin
    case (ctrl)
        2'b00 : r_next = r_reg;
        2'b01 : r_next = {r_reg[6:0], 1'b0};
        2'b10 : r_next = {1'b0, r_reg[7:1]};
        2'b11 : r_next = d;
    endcase    
end

// serial to parallel load
// parallel to serial load

//output logic
assign q = r_reg;
endmodule