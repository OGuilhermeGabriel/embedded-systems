module bwcomparator #(parameter N = 4) (
    input  [N-1:0] a, 
    input  [N-1:0] b, 
    output eq, 
    output lt, 
    output gt
);
  // Fios internos para guardar resultados bit a bit
  wire [N-1:0] eq_bit, lt_bit, gt_bit;

  // Geração automática dos comparadores de 1 bit
  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : comp
      onecomparator u_cmp (
        .a(a[i]),
        .b(b[i]),
        .eq(eq_bit[i]),
        .lt(lt_bit[i]),
        .gt(gt_bit[i])
      );
    end
  endgenerate

  // Comparação entre vetores (forma em cascata)
  assign eq = &eq_bit;   // AND de todos eq_bit → só 1 se todos os bits forem iguais

  assign gt = gt_bit[N-1] |
              (eq_bit[N-1] & gt_bit[N-2]) |
              (eq_bit[N-1] & eq_bit[N-2] & gt_bit[N-1-2]) |
              (eq_bit[N-1] & eq_bit[N-2] & eq_bit[N-3] & gt_bit[0]);

  assign lt = lt_bit[N-1] |
              (eq_bit[N-1] & lt_bit[N-2]) |
              (eq_bit[N-1] & eq_bit[N-2] & lt_bit[N-1-2]) |
              (eq_bit[N-1] & eq_bit[N-2] & eq_bit[N-3] & lt_bit[0]);

endmodule