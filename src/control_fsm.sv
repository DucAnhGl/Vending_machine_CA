module control_fsm (
    input  logic clk, reset_ni,
    input  logic pressed_i,
    output logic enable_o
);

    localparam IDLE  = 0;
    localparam ACCUM = 1;

    logic state, nextstate;

    always @(posedge clk or negedge reset_ni) begin
        if (!reset_ni) state <= IDLE;
        else state <= nextstate;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (pressed_i) nextstate <= ACCUM;
                else nextstate <=IDLE;
                enable_o <= 0;
            end
            ACCUM: begin
                if (pressed_i) nextstate <= ACCUM;
                else nextstate <= IDLE;
                enable_o <= 1;
            end
            default: begin
                nextstate <= ACCUM;
                enable_o <= 0;
            end
        endcase
    end

    
endmodule