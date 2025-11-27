module datapath (
    input clk, rst, ld, clr, // signals for tot's register
    input [7:0] s,           // product value
    input [7:0] a,           // coin value
    output wire h                 // status: deposited value >= product value
);
    reg [7:0] tot;                // register for accumulated value
    // tot's accumulator (register with load, clear and trigged by clk, rst)
    always @(posedge clk or posedge rst) begin
        if (rst)
            tot <= 8'd0;
        else if (clr)
            tot <= 8'd0;
        else if (ld)
            tot <= tot + a;  // accumulate coin value
    end
    // Comparator's output (combinational logic)
    assign h = (tot >= s) ? 1'b1 : 1'b0;
endmodule