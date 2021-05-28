`timescale 1ns/1ns

module reg_file_tb;
    reg clk;
    reg wr_en;
    reg [1:0] w_addr, r_addr;
    reg [7:0] w_data;
    wire [7:0] r_data;

   reg_file circuit1(clk, wr_en, w_addr, w_data, r_addr, r_data);

   always begin
      clk = ~clk;
      #10;
   end

   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0, reg_file_tb);

      clk <= 1'b0;
      wr_en <= 1'b0;
      r_addr <= 2'b00;
      w_addr <= 2'b00;
      w_data <= 8'b0000_0000;
      #20;

      wr_en <= 1'b1;
      w_addr <= 2'b01;
      w_data <= 8'b0000_1111;
      #20;

      r_addr <= 2'b01;
      #20;

      $finish;

   end

   initial begin
      $monitor("clk=%b, wr_en=%b, r_addr=%2b, w_addr=%2b, w_data=%8b, r_data=%8b", clk, wr_en, r_addr, w_addr, w_data, r_data);   
   end

endmodule