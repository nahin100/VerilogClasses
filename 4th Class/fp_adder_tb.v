`timescale 1ns/1ps

module fp_adder_tb;
    wire sign1, sign2;
    wire [3:0] exp1, exp2;
    wire [7:0] frac1, frac2;
    wire sign_out;
    wire [3:0] exp_out;
    wire [7:0] frac_out;

    assign sign1 = 1'b0;
    assign exp1 = 4'b0100;
    assign frac1 = 8'b1000_0100;

    assign sign2 = 1'b0;
    assign exp2 = 4'b0011;
    assign frac2 = 8'b1000_1000;

   fp_adder fp_unit
      (.sign1(sign1), .sign2(sign2), .exp1(exp1), .exp2(exp2),
       .frac1(frac1), .frac2(frac2), .sign_out(sign_out),
       .exp_out(exp_out), .frac_out(frac_out));

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, fp_adder_tb);
    end

    initial begin
      $monitor("sign_out=%1b, exp_out=%4b, frac_out=%8b", sign_out, exp_out, frac_out);   
   end
endmodule   


