module top(
    input CLK,       // O clock de 27 MHz da Tang Nano 1K
    output LED_OUT   // Saída conectada ao LED on-board
);

// Define a largura do contador. 
// O clock é 27.000.000 Hz. Para piscar a 1 Hz, precisamos dividir por 27.000.000.
// Usamos um valor um pouco menor (13.500.000) para toggle a 1 Hz.
// 27.000.000 / 2^24 é aproximadamente 1.6 Hz. 25 bits é melhor.
localparam COUNT_MAX = 27_000_000; // Conta até 27 milhões para ~0.5Hz/toggle a 1Hz

reg [24:0] counter = 25'd0; // Contador de 25 bits (suficiente para contar até 27M)
reg led_state = 1'b0;      // Registrador para o estado do LED

// Lógica de contagem
always @(posedge CLK) begin
    if (counter == COUNT_MAX) begin
        counter <= 25'd0;       // Reinicia o contador
        led_state <= ~led_state; // Inverte o estado do LED (toggle)
    end else begin
        counter <= counter + 1'b1; // Incrementa o contador
    end
end

// Atribui o estado do registrador à saída do pino do LED
assign LED_OUT = led_state;

endmodule

