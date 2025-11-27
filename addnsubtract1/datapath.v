module datapath (
    input clk, input rst, input ld, input clr, input s, output CM,
    output Cm, output [15:0] C_out
);
    reg [15:0] C;
    assign C_out = C;
    // Intermediate signals
    wire [15:0] C_plus_1, C_minus_1, C_next;

    // Instantiating the combinational blocks for the datapath
    fulladder16     adder (.A(C), .B(16'h0001), .S(C_plus_1));
    subtractor16    subtr (.A(C), .B(16'h0001), .S(C_minus_1));
    mux2x1 		     mux   (.in0(C_plus_1), .in1(C_minus_1), .s(s), .out(C_next));
    comparator_CM   cmpM  (.C(C), .CM(CM));
    comparator_Cm   cmpm  (.C(C), .Cm(Cm));

    // State register for C (sequential logic)
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            C <= 16'h0000;
        else if (clr == 1'b1)
            C <= 16'h0000;
        else if (ld == 1'b1)
            C <= C_next;
    end
endmodule