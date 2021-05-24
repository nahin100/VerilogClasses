module barrel_shifter (
    input wire [7:0] a,
    input wire [2:0] amt,
    output reg [7:0] y
);

always @(*) 
begin
    case (amt)
        3'd0: y = a;
        3'd1: y = {a[0], a[7:1]};
        3'd2: y = {a[1:0], a[7:2]};
        3'd3: y = {a[2:0], a[7:3]};

    endcase
end
    
endmodule