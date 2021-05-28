`timescale 1ns/1ps

module fp_adder_test;
   reg sign1, sign2;
   reg [3:0] exp1, exp2;
   reg [7:0] frac1, frac2;
   wire sign_out;
   wire [3:0] exp_out;
   wire [7:0] frac_out;

   fp_adder fp_unit
      (.sign1(sign1), .sign2(sign2), .exp1(exp1), .exp2(exp2),
       .frac1(frac1), .frac2(frac2), .sign_out(sign_out),
       .exp_out(exp_out), .frac_out(frac_out));

   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0, fp_adder_test);

      sign1 = 1'b0;
      exp1 = 4'b0100;
      frac1 = 8'b10000100;

      sign2 = 1'b0;
      exp2 = 4'b0011;
      frac2 = 8'b10001000;
   end

   initial begin
      $monitor("sign_out=%1b, exp_out=%4b, frac_out=%8b", sign_out, exp_out, frac_out);   
   end

endmodule