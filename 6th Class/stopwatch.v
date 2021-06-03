module stopwatch 
(
    input wire clk,
    input wire reset,
    output wire [3:0] d,
    output wire max_tick
);

//T = 20ns 
//f = 1/T = 50 x 10^6 Hz
//1s -> 50 x 10^6 pulse
// 50 x 10^6 pulse -> 1s
// 1 pulse -> 1s / (50 x 10^6)
// 5 x 10^6 pulse -> 0.1s
// Register size = log2(5x10^6) = 22.25 => 23 bits
// Save 9 value in register = 4 bits
// 1s second a tick generate korbe means output 1 hobe

// localparam DVSR = 5000000;
localparam DVSR = 2;

wire [22:0] ms_next;
reg [22:0] ms_reg;

wire [3:0] second_counter_next;
reg [3:0] second_counter_reg;


//memory/register/d_ff
always @(posedge clk, posedge reset) 
begin
    if (reset)
    begin
        ms_reg <= 23'b0000_0000_0000_0000_0000_000;
        second_counter_reg <= 4'b0000;        
    end
    else
    begin
        ms_reg <= ms_next;   
        second_counter_reg <= second_counter_next;        
    end
end

//nex state logic
assign ms_next = ms_reg + 1;
assign second_counter_next = (ms_reg==DVSR) ? second_counter_reg + 1 : second_counter_reg;

//output logic
assign d = second_counter_reg;
assign max_tick = (second_counter_reg==4'b1010) ? 1'b1 : 1'b0;

    
endmodule