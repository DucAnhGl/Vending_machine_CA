module register (
    input  logic clk,
    input  logic in_i,
    output logic out_o 
);

    always @(posedge clk) begin
        out_o <= in_i;
    end
    
endmodule