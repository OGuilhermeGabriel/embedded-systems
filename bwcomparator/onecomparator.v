module onecomparator (
    input  a, 
    input  b, 
    output eq, 
    output lt, 
    output gt
);
  assign eq = ~(a ^ b);   // mais simples: eq = 1 quando a == b
  assign lt = (~a & b);   // lt = 1 quando a < b
  assign gt = (a & ~b);   // gt = 1 quando a > b
endmodule