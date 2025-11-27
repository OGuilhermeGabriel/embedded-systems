module top (
  input wire clk, input wire rst, input wire [1:0] sel,
  output wire [7:0] total,
  output wire R
);

  wire ld, clr, op;
  wire cmp_ge80;

  datapath DP (
    .clk(clk),
    .rst(rst),
    .ld(ld),
    .clr(clr),
    .op(op),
    .sel(sel),
    .total(total),
    .cmp_ge80(cmp_ge80)
  );

  control CTRL (
    .clk(clk),
    .rst(rst),
    .cmp_ge80(cmp_ge80),
    .sel(sel),
    .ld(ld),
    .clr(clr),
    .op(op),
    .R(R)
  );
endmodule