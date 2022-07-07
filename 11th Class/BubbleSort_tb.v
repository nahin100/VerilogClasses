`timescale 1ns/1ps

module BubbleSort_tb 
(
    
);

reg clk;
reg reset;
reg start;
wire finish;

BubbleSort 
        #(
            .SIZE(4),
            .ADDR_WIDTH(2),
            .DATA_WIDTH(8)
        )
circuit1
        (
            .clk(clk), 
            .reset(reset), 
            .start(start), 
            .finish(finish)
        );

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, BubbleSort_tb);

    clk <= 0;
    reset <= 1;
    start <= 0;
    #20;

    reset <= 0;
    start <= 1;
    #20;

    start <= 0;
    #1000;

    $finish;
end

endmodule