module FSM1 
(
    input wire clk, reset,
    input wire a, b,
    output reg y0, y1
);

localparam [1:0] s0 = 2'b00,
                 s1 = 2'b01,
                 s2 = 2'b10,
                 error = 2'b11;

reg [1:0] state_reg, state_next;

//Memory
always @(posedge clk, posedge reset)
    if(reset)
        state_reg <= s0;
    else
        state_reg <= state_next;

//Next State Logic
always@(*)
begin
    $monitor("state_reg = %b\n clk = %b, reset = %b, a = %b, b = %b | y0 = %b, y1 = %b\n", state_reg, clk, reset, a, b, y0, y1);
    
    case(state_reg)
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
        default: state_next = error;
    endcase
end

//output logic
always@(*)
begin
    if(state_reg==s0 || state_reg==s1)
        y1 = 1;
    else
        y1 = 0;

    if(state_reg==s0 && a==1 && b==1)
        y0 = 1;
    else
        y0 = 0;
end

endmodule