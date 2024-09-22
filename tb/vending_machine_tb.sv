`timescale 1ns/1ns

module vending_machine_tb ();

    logic       clk, rst, nickel_i, dime_i, quarter_i, soda_o;
    logic [2:0] change_o;

    vending_machine_top vending_machine_top_tb (
        .clk_i    (clk),
        .reset_ni (rst),
        .nickel_i (nickel_i),
        .dime_i   (dime_i),
        .quarter_i(quarter_i),
        .soda_o   (soda_o),
        .change_o (change_o)
    );

    initial begin
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0,vending_machine_tb);
    end

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        rst =0;
        #2;
        rst =1;
    end

    initial begin
        nickel_i = 0;
        dime_i = 0;
        quarter_i = 0;

        #16;
        dime_i = 1;
        #10;
        dime_i = 0;
        #10;
        dime_i = 1;
        #10;
        dime_i = 0;

        #20;
        quarter_i = 1;
        #10;
        quarter_i = 0;

        #100;
        $finish();
    end
    
endmodule