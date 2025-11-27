module display_driver (
    input [15:0] bin,
    output reg [6:0] seg0, seg1, seg2, seg3, seg4 // Adicionado seg4
);
    // Adicionado d4 para o 5º dígito
    reg [3:0] d0, d1, d2, d3, d4; 
    integer i;
    reg [19:0] bcd;

    // Conversão binária → BCD (double dabble)
    always @(*) begin
        bcd = 20'd0;
        for (i = 15; i >= 0; i = i - 1) begin
            // Shift condicional para 5 dígitos BCD (d4 a d0)
            if (bcd[19:16] >= 5) bcd[19:16] = bcd[19:16] + 3; // d4
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3; // d3
            if (bcd[11:8]  >= 5) bcd[11:8]  = bcd[11:8]  + 3; // d2
            if (bcd[7:4]   >= 5) bcd[7:4]   = bcd[7:4]   + 3; // d1
            // Não precisa checar d0, pois ele é sempre o último a ser preenchido
            bcd = {bcd[18:0], bin[i]};
        end
        
        // Extrai os 5 dígitos BCD (20 bits / 4 bits por dígito = 5 dígitos)
        {d4, d3, d2, d1, d0} = bcd[19:0]; 
    end

    // Conversão dígito → 7 segmentos (comum catodo)

    // Lógica para d0 e seg0 (unidades)
    always @(*) begin
        case (d0)
            0: seg0 = 7'b1000000;
            1: seg0 = 7'b1111001;
            2: seg0 = 7'b0100100;
            3: seg0 = 7'b0110000;
            4: seg0 = 7'b0011001;
            5: seg0 = 7'b0010010;
            6: seg0 = 7'b0000010;
            7: seg0 = 7'b1111000;
            8: seg0 = 7'b0000000;
            9: seg0 = 7'b0010000;
            default: seg0 = 7'b1111111;
        endcase

        // Lógica para d1 e seg1 (dezenas)
        case (d1)
            0: seg1 = 7'b1000000;
            1: seg1 = 7'b1111001;
            2: seg1 = 7'b0100100;
            3: seg1 = 7'b0110000;
            4: seg1 = 7'b0011001;
            5: seg1 = 7'b0010010;
            6: seg1 = 7'b0000010;
            7: seg1 = 7'b1111000;
            8: seg1 = 7'b0000000;
            9: seg1 = 7'b0010000;
            default: seg1 = 7'b1111111;
        endcase

        // Lógica para d2 e seg2 (centenas)
        case (d2)
            0: seg2 = 7'b1000000;
            1: seg2 = 7'b1111001;
            2: seg2 = 7'b0100100;
            3: seg2 = 7'b0110000;
            4: seg2 = 7'b0011001;
            5: seg2 = 7'b0010010;
            6: seg2 = 7'b0000010;
            7: seg2 = 7'b1111000;
            8: seg2 = 7'b0000000;
            9: seg2 = 7'b0010000;
            default: seg2 = 7'b1111111;
        endcase

        // Lógica para d3 e seg3 (milhares)
        case (d3)
            0: seg3 = 7'b1000000;
            1: seg3 = 7'b1111001;
            2: seg3 = 7'b0100100;
            3: seg3 = 7'b0110000;
            4: seg3 = 7'b0011001;
            5: seg3 = 7'b0010010;
            6: seg3 = 7'b0000010;
            7: seg3 = 7'b1111000;
            8: seg3 = 7'b0000000;
            9: seg3 = 7'b0010000;
            default: seg3 = 7'b1111111;
        endcase

        // Lógica para d4 e seg4 (dezena de milhares) - NOVO!
        case (d4)
            0: seg4 = 7'b1000000;
            1: seg4 = 7'b1111001;
            2: seg4 = 7'b0100100;
            3: seg4 = 7'b0110000;
            4: seg4 = 7'b0011001;
            5: seg4 = 7'b0010010;
            6: seg4 = 7'b0000010;
            7: seg4 = 7'b1111000;
            8: seg4 = 7'b0000000;
            9: seg4 = 7'b0010000;
            default: seg4 = 7'b1111111;
        endcase
    end
endmodule