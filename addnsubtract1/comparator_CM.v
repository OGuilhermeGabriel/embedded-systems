module comparator_CM (
    input  [15:0] C,
    output CM
);
    assign CM = (C < 16'hFFFF);
endmodule
