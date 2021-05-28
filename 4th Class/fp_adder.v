module fp_adder 
(
    input wire sign1, sign2,
    input wire [3:0] exp1, exp2,
    input wire [7:0] frac1, frac2,
    output reg sign_out,
    output reg [3:0] exp_out,
    output reg [7:0] frac_out
);

//1.sorting
reg signb, signs;
reg [3:0] expb, exps, exp_diff, exp_normalize;
reg [7:0] fracb, fracs;
reg [8:0] sum, sum_normalize;
reg [2:0] lead;

//{exp1,frac1} {exp2,frac2}
always @(*) begin
    if (exp1 > exp2)
        begin
            signb = sign1;
            expb = exp1;
            fracb = frac1;
            signs = sign2;
            exps = exp2;
            fracs = frac2;
        end 
    else if (exp1==exp2)
        begin
            if (frac1 > frac2)
                begin
                    signb = sign1;
                    expb = exp1;
                    fracb = frac1;
                    signs = sign2;
                    exps = exp2;
                    fracs = frac2;
                end 
            else
                begin
                    signb = sign2;
                    expb = exp2;
                    fracb = frac2;
                    signs = sign1;
                    exps = exp1;
                    fracs = frac1;                                
                end
        end
    else
        begin
            signb = sign2;
            expb = exp2;
            fracb = frac2;
            signs = sign1;
            exps = exp1;
            fracs = frac1;            
        end    

//2. Alignment
exp_diff = expb-exps;
fracs = fracs >> exp_diff;
exps = exps + exp_diff;

//3. add/subtract
if (signb==signs)
    sum = {1'b0, fracb} + {1'b0, fracs}; 
else
    sum = {1'b0, fracb} - {1'b0, fracs};

//4. normalize
//Case 1: Check whether MSB of significand (f) is 1
//Case 2: There is a carry
//Case 3: too small to normalize
if (sum[7]==1)
    lead = 0;
else if(sum[6]==1)
    lead = 1;

sum_normalize = sum << lead;
exp_normalize = expb - lead;

if (sum[8] == 1)
{
    
}



sign_out = signb;
exp_out = expb;
frac_out = sum[7:0];
    
end


endmodule