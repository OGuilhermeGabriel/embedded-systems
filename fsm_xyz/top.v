module top(
    input CLOCK_50,
    input [3:0] KEY,
    output [2:0] LEDG
);
    wire slow_clk;

    clock_div div0 (
        .clk_in(CLOCK_50),
        .clk_out(slow_clk)
    );

    fsm_xyz DUT (
        .clk(slow_clk),
        .rst(KEY[0]),
        .xyz(LEDG)
    );
endmodule
