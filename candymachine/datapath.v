module datapath (
  input wire clk, input wire rst, input wire ld, input wire clr, input wire op,
  input wire [1:0] sel,
  output reg [7:0] total, // valor acumulado em centavos (0–255)
  output wire cmp_ge80     // 1 se total >= 80
);

  reg [7:0] coin_value;

  // Define valor da moeda
  always @(*) begin
    case (sel)
      2'b00: coin_value = 8'd0;
      2'b01: coin_value = 8'd5;   // 0.05
      2'b10: coin_value = 8'd10;  // 0.10
      2'b11: coin_value = 8'd25;  // 0.25
      default: coin_value = 8'd0;
    endcase
  end
  // Acumulador
  always @(posedge clk or posedge rst) begin
    if (rst)
      total <= 8'd0;
    else if (clr)
      total <= 8'd0;
    else if (ld) begin
      if (op)
        total <= total + coin_value;   // soma
      else
        total <= total - 8'd80;        // subtrai 0,80
    end
  end
  // Comparador
  assign cmp_ge80 = (total >= 8'd80);
endmodule