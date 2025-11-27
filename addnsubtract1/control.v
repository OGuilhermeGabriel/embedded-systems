module control (
    input clk, input rst, input U, input D, input CM, input Cm,
    output reg ld, output reg clr, output reg s
);
    // Mapping states
    parameter init = 2'b00;
    parameter print = 2'b01;
    parameter add = 2'b10;
    parameter dec = 2'b11;

    // States Variables
    reg [1:0] currState, nextState;

    //States Register (REG -> Sequential Logic) 
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            currState <= init;
        end else begin 
            currState <= nextState;
        end
    end

    //Next State Logic (COMB -> Combinational Logic)
    always @(*) begin
        nextState = currState;
        // initializing variable states
        ld  = 1'b0;
        clr = 1'b0;
        s   = 1'b0;
        case (currState)
            init: begin
                nextState = print;
                ld  = 1'b0;
                clr = 1'b1;
                s   = 1'b0;
            end
            print: begin
                ld  = 1'b0;
                clr = 1'b0;
                s   = 1'b0;
                if (U && CM) nextState = add;
                else if (D && Cm) nextState = dec;
            end
            add: begin
                ld = 1'b1;
                clr = 1'b0;
                s  = 1'b0; //c <= c+1
                nextState = print;
            end
            dec: begin
                ld = 1'b1;
                clr = 1'b0;
                s  = 1'b1; // c <= c-1
                nextState = print;
            end
        endcase
    end
endmodule