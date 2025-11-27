module clock_div(
    input clk_in,
    output reg clk_out
);
    reg [23:0] counter = 0;

    always @(posedge clk_in) begin
        counter <= counter + 1;
        clk_out <= counter[23]; // divide 50 MHz por 2^24 ≈ 3 Hz
    end
endmodule

