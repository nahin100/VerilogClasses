module Fibo 
(
    input wire clk, reset,
    input wire start,
    input wire [4:0] i,
    output reg finish,
    output reg [19:0] result
);

localparam [1:0] idle = 2'b00,
                 op = 2'b01,
                 done = 2'b10,
                 error = 2'b11;

reg [1:0] state_reg, state_next;
reg [19:0] t0_reg, t0_next;
reg [19:0] t1_reg, t1_next;
reg [4:0] n_reg, n_next;


//Memory
always @(posedge clk, posedge reset)
    if(reset)
    begin
        state_reg <= idle;
        t0_reg <= 0;
        t1_reg <= 0;
        n_reg <= 0;
    end
    else
    begin
        state_reg <= state_next;
        t0_reg <= t0_next;
        t1_reg <= t1_next;
        n_reg <= n_next;
    end

//Next State Logic
always@(*)
begin
    $monitor("state_reg = %b\n t0 = %d, t1 = %d, n = %d \n | clk = %b, reset = %b, start = %b, i = %d \n | finish = %b, result = %d\n", state_reg, t0_reg, t1_reg, n_reg, clk, reset, start, i, finish, result);
    
    state_next = state_reg;
    t0_next = t0_reg;
    t1_next = t1_reg;
    n_next = n_reg;

    finish = 'b0;
    result = 'b0;

    case(state_reg)
        idle: 
            if(start)
                begin
                    t0_next = 'b0;
                    t1_next = 'b1;
                    n_next = i;
                    state_next = op;
                end

        op: 
            if(n_reg==0)
            begin
                t1_next = 0;
                state_next = done;
            end
            else if(n_reg == 1)
            begin
                state_next = done;
            end
            else
            begin
                t0_next = t1_reg;
                t1_next = t0_reg + t1_reg;
                n_next = n_reg - 1;
            end
        done: 
            begin
                finish = 'b1;
                result = t1_reg;
            end
        default: state_next = error;
    endcase
end

//output logic
    
endmodule