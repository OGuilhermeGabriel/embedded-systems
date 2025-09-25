module fsm_8states (
    input  wire clk,      // Clock externo (do gerador)
    input  wire rst,      // Reset síncrono
    input  wire btn,      // Botão para avançar o estado
    output reg  [2:0] state // Estado atual (000 ate 111)
);

    // Registrador auxiliar para detectar borda do botão
    reg btn_sync0, btn_sync1;

    // Sincronização do botão com o clock (evita metastabilidade)
    always @(posedge clk) begin
        btn_sync0 <= btn;
        btn_sync1 <= btn_sync0;
    end

    wire btn_rising = btn_sync0 & ~btn_sync1; // Detecta borda de subida

    // Máquina de estados
    always @(posedge clk) begin
        if (rst) begin
            state <= 3'b000;  // reset: volta ao estado 000
        end else if (btn_rising) begin
            if (state == 3'b111)
                state <= 3'b000; // se chegar em 7, volta pra 0
            else
                state <= state + 1; // avança normalmente
        end else begin
            state <= state; // permanece no mesmo estado
        end
    end

endmodule
