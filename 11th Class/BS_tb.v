`timescale 1ns/1ps

module BS_tb 
(
);

reg clk;
reg reset;
reg start;
wire finish;

BS #(.ADDR_WIDTH(2), .DATA_WIDTH(8))
BScircuit
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
    $dumpvars(0, BS_tb);

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

// initial begin
//     $monitor("clk = %b, reset = %b, start = %b, finish = %b\n", clk, reset, start, finish);
// end
    
endmodule
