module two_to_one_MUX
(
    input wire A,
    input wire B,
    input wire S,
    output wire z
//    output wire cout
);

//assign z = (A&~S) | (B&S);
assign z = (S==1'b0) ? A :
           (S==1'b1) ? B :
           1'bX;

endmodule