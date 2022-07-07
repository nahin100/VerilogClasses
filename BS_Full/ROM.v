module ROM 
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8
)
(
    input wire [ADDR_WIDTH-1:0] read_addr,
    output reg [DATA_WIDTH-1:0] read_data
);

always @(*) 
begin
    case(read_addr)
        12'h000: read_data = 'b0000_0011;
        12'h001: read_data = 'b0000_0010;
        12'h002: read_data = 'b0000_0001;
        12'h003: read_data = 'b0000_0000;
        12'h004: read_data = 'd4;
        12'h006: read_data = 'd5;
        default: read_data = 'd255;   
    endcase 
end


endmodule