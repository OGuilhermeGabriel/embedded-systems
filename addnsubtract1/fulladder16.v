module fulladder16 (
    input [15:0] A, input [15:0] B,
    output [15:0] S
);
    assign S = A + B;
endmodule