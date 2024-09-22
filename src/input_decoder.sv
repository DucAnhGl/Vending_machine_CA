module input_decoder (
    input  logic       nickel_i, dime_i, quarter_i,
    output             pressed_i,
    output logic [4:0] value_o
);

    assign pressed_i = nickel_i | dime_i | quarter_i;

    always @(*) begin
        if (nickel_i & (!dime_i) & (!quarter_i)) value_o <= 5;
        else if ((!nickel_i) & (dime_i) & (!quarter_i)) value_o <= 10;
        else if ((!nickel_i) & (!dime_i) & (quarter_i)) value_o <= 25;
        else value_o <= 0;
    end
    
endmodule