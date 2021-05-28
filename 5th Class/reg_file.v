module reg_file (
    input wire clk,

    input wire wr_en,    
    input wire [1:0] w_addr,
    input wire [7:0] w_data,

    input wire [1:0] r_addr,
    output wire [7:0] r_data
);

reg [7:0] array_reg [3:0];

always @(posedge clk) 
begin
    if (wr_en)
        array_reg[w_addr] <= w_data;    
end

assign r_data = array_reg[r_addr];
    
endmodule