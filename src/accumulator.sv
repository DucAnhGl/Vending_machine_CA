module accumulator (
    input  logic       reset_ni, enable_pi,
    input  logic [4:0] in_i,
    output logic [5:0] result_o
);

    always @(posedge enable_pi or negedge reset_ni) begin
        if (!reset_ni) result_o <= 0;
        else if (enable_pi) result_o <= result_o + in_i;
        else result_o <= result_o;
    end
    
endmodule