module top(
    input CLK,           // Clock de 27 MHz da TangNano1K
    output LED_EXT       // GPIO externo conectado ao LED
);

localparam COUNT_MAX = 27_000_000;   // Conta até 27 milhões para ~0.5Hz

reg [24:0] counter = 25'd0;
reg led_state = 1'b0;

// Lógica do contador
always @(posedge CLK) begin
    if (counter == COUNT_MAX) begin
        counter <= 25'd0;
        led_state <= ~led_state;
    end else begin
        counter <= counter + 1'b1;
    end
end

assign LED_EXT = led_state;

endmodule
