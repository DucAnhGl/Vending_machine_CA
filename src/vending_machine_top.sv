module vending_machine_top (
    input  logic       clk_i,
    input  logic       reset_ni,
    input  logic       nickel_i, dime_i, quarter_i,
    output logic       soda_o,
    output logic [2:0] change_o
);

    logic pressed, reset, comp_reset, enable;
    logic [4:0] input_value;
    logic [5:0] accum_result;

    assign pressed = nickel_i | dime_i | quarter_i;
    assign reset   = reset_ni & comp_reset;

    input_decoder input_decoder_inst (
        .nickel_i (nickel_i),
        .dime_i   (dime_i),
        .quarter_i(quarter_i),
        .value_o  (input_value)
    );

    accumulator accumulator_inst (
        .reset_ni (reset),
        .enable_pi(enable),
        .in_i     (input_value),
        .result_o (accum_result)    
    );

    comparator_20 comparator_20_inst (
        .in_i    (accum_result),
        .valid_o (soda_o),
        .change_o(change_o)
    );

    register register_inst (
        .clk  (clk_i),
        .in_i (~soda_o),
        .out_o(comp_reset)
    );

    control_fsm control_fsm_inst (
        .clk      (clk_i),
        .reset_ni (reset_ni),
        .pressed_i(pressed),
        .enable_o (enable)
    );

    
endmodule