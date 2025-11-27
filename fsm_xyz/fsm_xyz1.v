module fsm_xyz(
    input clk,
    input rst,
    output reg [2:0] xyz
);
    // Mapping states
    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter s3 = 2'b11;

    // State registers
    reg [1:0] currState, nextState;

    // Sequential logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            currState <= s0;
        end else begin
            currState <= nextState;
        end
    end

    // Next-state logic
    always @(*) begin
        case (currState)
            s0: begin xyz = 3'b000; nextState = s1; end
            s1: begin xyz = 3'b001; nextState = s2; end
            s2: begin xyz = 3'b010; nextState = s3; end
            s3: begin xyz = 3'b100; nextState = s0; end
            default: begin xyz = 3'b000; nextState = s0; end
        endcase
    end
endmodule