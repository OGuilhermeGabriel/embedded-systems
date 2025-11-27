module top (
    input clk, input rst, input U, input D,
    output [15:0] LEDS // Saídas de 16 bits para 16 LEDs
);
    wire ld, clr, s; // controle
    wire CM, Cm;     // status
    wire [15:0] C_val; // valor de C (o valor que queremos exibir)

    // Conexão direta do valor C para as saídas de LED
    assign LEDS = C_val; 

    control UC (
        .clk(clk),
        .rst(rst),
        .U(U),
        .D(D),
        .CM(CM),
        .Cm(Cm),
        .ld(ld),
        .clr(clr),
        .s(s)
    );

    datapath DP (
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .clr(clr),
        .s(s),
        .CM(CM),
        .Cm(Cm),
        .C_out(C_val)
    );  
endmodule