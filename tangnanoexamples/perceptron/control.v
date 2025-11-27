module control (
    input clk, input rst,
    //sinais de status que entram
    input Epm, input Nm,
    //sinais de controle que saem
    output reg ld_N, output reg clr_N, output reg ld_Ep, output reg clr_Ep, output reg ld_w, output reg clr_w, output reg ld_e, output reg clr_e
);

    //declarando os registradores de estados: barramento é 2: 2^n >= states
    reg [1:0] estado_atual, estado_proximo;

    //decodificando os estados
    parameter Start = 2'b00,
              Wait  = 2'b01,
              Forward = 2'b10,
              Backpropagation = 2'b11;

    //lógica do registrador de estados (REG)
    always @(posedge clk or posedge rst) begin
        if (rst)
            estado_atual <= Start;
        else
            estado_atual <= estado_proximo;
    end

    //lógica de transição para os próximos estados e de saídas (COMB)
    always @(*) begin
        //setando valores em zero inicialmente, para evitar latches
        estado_proximo = estado_atual;
        ld_N = 1'b0; clr_N = 1'b0;
        ld_Ep = 1'b0; clr_Ep = 1'b0;
        ld_w = 1'b0; clr_w = 1'b0;
        ld_e = 1'b0; clr_e = 1'b0;

        case (estado_atual)
            Start: begin
                clr_Ep = 1'b1;
                clr_w  = 1'b1;
                clr_e  = 1'b1;
                estado_proximo = Wait;
            end

            Wait: begin
                clr_N = 1'b1;// as amostras são zeradas
                ld_Ep = 1'b1;// incrementa uma nova época
                if (Epm)
                    estado_proximo = Forward;
                else
                    estado_proximo = Wait;
            end

            Forward: begin
                // calcula soma, y_pred e erro_wire, ou seja, carrega erro
                ld_e = 1'b1;
                estado_proximo = Backpropagation;
            end

            Backpropagation: begin
                // usa o erro armazenado no registrador do estado "foward" passado para atualizar os pesos e computar a amostra
                ld_w = 1'b1;
                ld_N = 1'b1;
                if (Nm)
                    estado_proximo = Forward;
                else
                    estado_proximo = Wait;
            end

            default: estado_proximo = Start;
        endcase
    end
endmodule
