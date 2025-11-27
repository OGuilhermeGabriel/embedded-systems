module top (
    input wire clk,
    input wire rst,
    input wire [7:0] s,  // custo do produto
    input wire [7:0] a,  // valor da moeda
    input wire c,        // moeda depositada
    output wire d        // libera produto
);
    wire ld, clr, h;
    // Instancia datapath
    datapath DP (
        .clk(clk),
        .rst(rst),
        .s(s),
        .a(a),
        .ld(ld),
        .clr(clr),
        .h(h)
    );
    // Instancia unidade de controle
    control CTRL (
        .clk(clk),
        .rst(rst),
        .c(c),
        .h(h),
        .ld(ld),
        .clr(clr),
        .d(d)
    );
endmodule