module mux2x1(
    input [15:0] in0, input [15:0] in1, input s,
    output [15:0] out
);
    assign out = (s == 1'b0) ? in0 : in1;
endmodule