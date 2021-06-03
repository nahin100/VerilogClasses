module fsm_ex1_type1 (
    input wire clk, reset,
    input wire a, b,
    output wire y0, y1
);

localparam [1:0] s0 = 2'b00;
localparam [1:0] s1 = 2'b01;
localparam [1:0] s2 = 2'b10;

reg [1:0] state_reg, state_next;

//memory/register/D FF
always @(posedge clk, posedge reset) 
begin
    if (reset)
        state_reg <= 2'b00;        
    else
        state_reg <= state_next;   
end

//next state logic
always @(*) 
begin
    case (state_reg)
        s0: if(a)
                if(b)
                    state_next = s2;
                else
                    state_next = s1;
            else
                state_next = s0;
        
        s1: if(a)
                state_next = s0;
            else
                state_next = s1;

        s2: state_next = s0;
        default: state_next = s0;
    endcase
end

//output logic
assign y1 = (state_reg==s0) || (state_reg==s1);
assign y0 = (state_reg==s0) & a & b;

endmodule