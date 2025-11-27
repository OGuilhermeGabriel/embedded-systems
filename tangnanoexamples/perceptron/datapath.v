module datapath(
    input clk,
    //entradas vindas do controle para a entrada do datapath (comandos)
    input ld_N, clr_N, ld_Ep, clr_Ep, ld_w, clr_w, ld_e, clr_e,
    //constante de 4 bits que será definida no "top.v" para determinar
    //a quantidade de epocas 
    input [3:0] Epocas,
    //saídas do controle para o datapath (sinais de status)
    output Epm, output Nm,
    // os pesos recalculados que sairão do datapath 
    output reg signed [7:0] w0,
    output reg signed [7:0] w1
);
    
    //registradores N EP, para ficar acumulando as amostras e as épocas
    reg [3:0] N;
    reg [3:0] EP;
    reg signed [1:0] Erro;  //registrador de erro

    //registradores para representar a tabela OR: xi, xj e y (y_target)
    reg [1:0] x [0:3];
    reg y_target [0:3];

    //sinais intermediarios das saídas de circuitos combinacionais
    wire signed [8:0] soma;
    wire y_pred;
    wire signed [1:0] erro_wire;
    
    //limiar = 1, determinado pelo projeto 
    parameter signed limiar = 1;

    // inicializando a tabela verdade OR juntamente com os pesos, amostras,
    // erro e épocas
    initial begin
        x[0] = 2'b00; y_target[0] = 1'b0;
        x[1] = 2'b01; y_target[1] = 1'b1;
        x[2] = 2'b10; y_target[2] = 1'b1;
        x[3] = 2'b11; y_target[3] = 1'b1;
        w0 = 8'sd0;
        w1 = 8'sd0;
        N = 4'd0;
        EP = 4'd0;
        Erro = 2'sd0;
    end

    // calculando o y_pred
    wire signed [7:0] part0 = (x[N][0] ? w0 : 8'sd0); 
    wire signed [7:0] part1 = (x[N][1] ? w1 : 8'sd0);
    assign soma = part0 + part1; // a soma representa o "Z" do "g(Z)"
    assign y_pred = (soma >= limiar) ? 1'b1 : 1'b0;

    // calculando o erro 
    assign erro_wire = $signed({1'b0, y_target[N]}) - $signed({1'b0, y_pred});

    // Status
    assign Epm = (EP < Epocas) ? 1'b1 : 1'b0;
    assign Nm  = (N  < 4) ? 1'b1 : 1'b0;

    //definindo o que os comandos vindos do controle irão impactar nos
    //calculos do datapath
    always @(posedge clk) begin
        //N - zerar ou acumular mais 1 amostra 
        if (clr_N)
            N <= 4'd0;
        else if (ld_N)
            N <= N + 4'd1;

        //EP - zerar ou acumular mais 1 época
        if (clr_Ep)
            EP <= 4'd0;
        else if (ld_Ep)
            EP <= EP + 4'd1;

        //Erro - zerar ou atualizar o erro 
        if (clr_e)
            Erro <= 2'sd0;
        else if (ld_e)
            Erro <= erro_wire;

        //clr_w e ld_w irao zerar ou atualizar os pesos
        if (clr_w) begin
            w0 <= 8'sd0;
            w1 <= 8'sd0;
        end
        else if (ld_w) begin
            w0 <= w0 + (Erro * x[N][0]);
            w1 <= w1 + (Erro * x[N][1]);
        end
    end
endmodule
