module top(clk, btn1, led);

   input clk;
   input btn1; //botao para começar o ajuste dos pesos
   output [5:0] led; //saida para vizualizar os pesos na FPGA

   //divisor de clock
   reg [23:0] contador = 24'hFFFFFF;
   reg clk_n;

   always @(posedge clk) begin
      if (!btn1)
         contador <= 24'd0;
      else if (contador == 24'd13500000)
         contador <= 24'd0;
      else
         contador <= contador + 1;
      clk_n = (contador == 24'd0);
   end

   //sinais de controle e status
   wire ld_N, clr_N, ld_Ep, clr_Ep, ld_w, clr_w, ld_e, clr_e;
   wire Epm, Nm;
   //pesos
   wire signed [7:0] w0, w1;

   wire rst = ~btn1; //reset ativo baixo, para a fpga

   //instanciando o bloco de controle
   control ctrl (
      .clk(clk_n),
      .rst(rst),
      .Epm(Epm),
      .Nm(Nm),
      .ld_N(ld_N),
      .clr_N(clr_N),
      .ld_Ep(ld_Ep),
      .clr_Ep(clr_Ep),
      .ld_w(ld_w),
      .clr_w(clr_w),
      .ld_e(ld_e),
      .clr_e(clr_e)
   );

   //instanciando o bloco de datapath
   datapath dp (
      .clk(clk_n),
      .ld_N(ld_N),
      .clr_N(clr_N),
      .ld_Ep(ld_Ep),
      .clr_Ep(clr_Ep),
      .ld_w(ld_w),
      .clr_w(clr_w),
      .ld_e(ld_e),
      .clr_e(clr_e),
      .Epocas(4'd10),
      .Epm(Epm),
      .Nm(Nm),
      .w0(w0),
      .w1(w1)
   );
   //LEDs: 5,4,3 → w1, 2,1,0 → w0
   assign led = {w1[2:0], w0[2:0]};
endmodule
