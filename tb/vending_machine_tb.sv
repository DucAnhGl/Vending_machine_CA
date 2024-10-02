`timescale 1ns/1ns

module vending_machine_tb ();

    logic       clk, rst, nickel_i, dime_i, quarter_i, soda_o;
    logic [2:0] o_change;

    vending_machine vending_machine_top_tb (
        .i_clk    (clk),
        .i_rstn   (rst),
        .i_nickle (nickel_i),
        .i_dime   (dime_i),
        .i_quarter(quarter_i),
        .o_soda   (soda_o),
        .o_change (o_change)
    );

    // Wave dump
    initial begin
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0,vending_machine_tb);
        #1000000;
        $display("Simulation finish at %0t", $time);
        $finish();
    end

    // File log dump
    integer fd;
    initial begin
        fd = $fopen("result.log","w");
    end
    
    // Clock gen
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    // Reset gen
    initial begin
        rst =0;
        #10;
        rst =1;
    end

    // Simulation
    integer total, cycle, coin, change, change_decode;
    initial begin
        nickel_i = 0;
        dime_i = 0;
        quarter_i = 0;
        total = 0;
        cycle = 0;
        coin = 3;
        change = 0;
        change_decode = 0;
        #1
        forever begin

            cycle = $urandom_range(0,5);
            coin = $urandom_range(0,2);
            repeat(cycle) #10;
            toggle_coin(coin);

            // Golden model in simulation
            if (coin == 0) begin
                total += 5;
                $fdisplay(fd, "At %0t ns: Nickle inserted", $time);
            end
            else if (coin == 1) begin
                total += 10;
                $fdisplay(fd, "At %0t ns: Dime inserted", $time);
            end
            else begin
                total += 25;
                $fdisplay(fd, "At %0t ns: Quarter inserted ", $time);
            end
            // Enough money in golden model so DUT should have enough as well
            if (total >= 20) begin
                change = total - 20;
                // Decode change for comparison
                case (change)
                    0: change_decode = 0;
                    5: change_decode = 1;
                    10: change_decode = 2;
                    15: change_decode = 3;
                    20: change_decode = 4; 
                endcase
                // If there is enough money but no soda then raise error
                if (!vending_machine_top_tb.o_soda) $fdisplay(fd, "At %0t ns: Soda out ERROR!!! Soda should be dispensed!, total: %0d", $time, total);
                // If total is 20, change is 0 cents, raise error if change amount is incorrect
                if (total == 20) begin
                    if (vending_machine_top_tb.o_change != change_decode) $fdisplay(fd, "At %0t ns: Change out ERROR!!! expect: %0b, change: %0b", $time, change_decode, vending_machine_top_tb.o_change);
                    else $fdisplay(fd, "At %0t ns: Change out, change: %0b\n", $time, vending_machine_top_tb.o_change);
                end
                // If total is 25, change is 5 cents, raise error if change amount is incorrect
                else if (total == 25) begin
                    if (vending_machine_top_tb.o_change != change_decode) $fdisplay(fd, "At %0t ns: Change out ERROR!!! expect: %0b, change: %0b", $time, change_decode, vending_machine_top_tb.o_change);
                    else $fdisplay(fd, "At %0t ns: Change out, change: %0b\n", $time, vending_machine_top_tb.o_change);
                end
                // If total is 30, change is 10 cents, raise error if change amount is incorrect
                else if (total == 30) begin
                    if (vending_machine_top_tb.o_change != change_decode) $fdisplay(fd, "At %0t ns: Change out ERROR!!! expect: %0b, change: %0b", $time, change_decode, vending_machine_top_tb.o_change);
                    else $fdisplay(fd, "At %0t ns: Change out, change: %0b\n", $time, vending_machine_top_tb.o_change);
                end
                // If total is 35, change is 15 cents, raise error if change amount is incorrect
                else if (total == 35) begin
                    if (vending_machine_top_tb.o_change != change_decode) $fdisplay(fd, "At %0t ns: Change out ERROR!!! expect: %0b, change: %0b", $time, change_decode, vending_machine_top_tb.o_change);
                    else $fdisplay(fd, "At %0t ns: Change out, change: %0b\n", $time, vending_machine_top_tb.o_change);
                end
                // If total is 40, change is 20 cents, raise error if change amount is incorrect
                else if (total == 40) begin
                    if (vending_machine_top_tb.o_change != change_decode) $fdisplay(fd, "At: %0t ns: Change out ERROR!!! expect: %0b, change: %0b", $time, change_decode, vending_machine_top_tb.o_change);
                    else $fdisplay(fd, "At %0t ns: Change out, change: %0b\n", $time, vending_machine_top_tb.o_change);
                end
                total = 0;
                #10;
            end else if (total < 20) begin
                // If there is not enough money but dump soda then raise error
                if (vending_machine_top_tb.o_soda) $fdisplay(fd, "At %0t ns: Soda out ERROR!!! NO soda should be dispensed!, total: %0d", $time, total);
            end else $fdisplay(fd, "Invalid total: %0d at %0t ns\n", total, $time);
            end
        end
    
    // Toggle a coin for 1 clock period
    task toggle_coin (input [1:0] coin_type); // 0 for nickel, 1 for dime, 2 for quarter
        case (coin_type) 
            2'h0: nickel_i = 1;
            2'h1: dime_i = 1;
            2'h2: quarter_i = 1;
        endcase
        #10
        case (coin_type) 
            2'h0: nickel_i = 0;
            2'h1: dime_i = 0;
            2'h2: quarter_i = 0;
        endcase
    endtask
    
endmodule