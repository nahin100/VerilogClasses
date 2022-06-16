module loadROMtoRAM 
#(
    parameter ADDR_WIDTH = 12,
              DATA_WIDTH = 8   
) 
(
    input wire start,
    input wire clk,
    input wire [ADDR_WIDTH-1:0] addr,
    output wire [DATA_WIDTH-1:0] data,
    output wire finish
);

// start
// op
// finish

wire [DATA_WIDTH-1:0] counter_data;

dualPortRAM circuit1 
(
    .clk(clk), 
    .we(we), 
    .read_addr_1(addr), 
    .write_addr(counter_reg), 
    .write_data(counter_data),
    .read_data_1(data),
);

ROM circuit1
(
    .read_addr(counter_reg), 
    .read_data(counter_data)
);


//Memory
reg [ADDR_WIDTH-1:0] counter_reg;
wire [ADDR_WIDTH-1:0] counter_next;

always @(posedge clk, posedge reset) 
begin
    if(reset)
        counter_reg <= 0;
    else
        counter_reg <= counter_next;
end


//Next State Logic
assign counter_next = counter_reg + 1;

//Output Logic
always @(*) 
begin
    q = counter_reg;
end
    
endmodule