module comparator_Cm (
    input  [15:0] C,
    output Cm
);
    assign Cm = (C > 16'h0000);
endmodule
