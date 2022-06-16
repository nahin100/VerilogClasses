module dualPortRAM 
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8
)
(
    input wire clk,
    input wire we,
    input wire [ADDR_WIDTH-1:0] read_addr_1,
    input wire [ADDR_WIDTH-1:0] read_addr_2,
    input wire [ADDR_WIDTH-1:0] write_addr,
    input wire [DATA_WIDTH-1:0] write_data,
    output wire [DATA_WIDTH-1:0] read_data_1,
    output wire [DATA_WIDTH-1:0] read_data_2
);

reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

always @(posedge clk) 
begin
    if(we)
        ram[write_addr] <= write_data;    
end

assign read_data_1 = ram[read_addr_1];
assign read_data_2 = ram[read_addr_2];

endmodule