module comparator_20 (
    input  logic [5:0] in_i,
    output logic       valid_o,
    output logic [2:0] change_o
);

    logic [5:0] change_temp;

    always @(*) begin
        if (in_i < 20) begin 
            valid_o <= 0;
            change_temp <= 0;
        end else if (in_i == 20) begin
            valid_o <= 1;
            change_temp <= 0;
        end else if (in_i > 20) begin
            valid_o <= 1;
            change_temp <= in_i - 20;
        end else change_o <= change_o;
    end

    always @(*) begin
        case (change_temp)
            6'h0:    change_o <= 3'b000;
            6'h5:    change_o <= 3'b001;
            6'd10:   change_o <= 3'b010;
            6'd15:   change_o <= 3'b011;
            6'd20:   change_o <= 3'b100;
            default: change_o <= 3'b000;
        endcase
    end

endmodule