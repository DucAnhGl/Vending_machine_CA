module vending_machine (
    input  logic       i_clk, i_rstn,
    input  logic       i_nickle, i_dime, i_quarter, // Nickle = 5, Dime = 10, Quarter = 25
    output logic       o_soda,
    output logic [2:0] o_change
);

    logic [3:0] state, next_state;

    localparam INIT        = 4'd0,
               FIVE        = 4'd1,
               TEN         = 4'd2,
               FIFTEEN     = 4'd3,
               TWENTY      = 4'd4,
               TWENTY_FIVE = 4'd5,
               THIRTY      = 4'd6,
               THIRTY_FIVE = 4'd7,
               FORTY       = 4'd8;

    // State sequential logic
    always @(posedge i_clk or negedge i_rstn) begin
        if (!i_rstn) begin 
            state <= INIT;
        end
        else state <= next_state;
    end

    // Next state combinational logic
    always @(*) begin
        case (state)
            INIT: begin
                if (i_nickle & (!i_dime) & (!i_quarter)) begin
                    next_state <= FIVE;
                end else if ((!i_nickle) & (i_dime) & (!i_quarter)) begin
                    next_state <= TEN;
                end else if ((!i_nickle) & (!i_dime) & (i_quarter)) begin
                    next_state <= TWENTY_FIVE;
                end else begin
                    next_state <= INIT;
                end
            end
            FIVE: begin
                if (i_nickle & (!i_dime) & (!i_quarter)) begin
                    next_state <= TEN;
                end else if ((!i_nickle) & (i_dime) & (!i_quarter)) begin
                    next_state <= FIFTEEN;
                end else if ((!i_nickle) & (!i_dime) & (i_quarter)) begin
                    next_state <= THIRTY;
                end else begin
                    next_state <= FIVE;
                end
            end
            TEN: begin
                if (i_nickle & (!i_dime) & (!i_quarter)) begin
                    next_state <= FIFTEEN;
                end else if ((!i_nickle) & (i_dime) & (!i_quarter)) begin
                    next_state <= TWENTY;
                end else if ((!i_nickle) & (!i_dime) & (i_quarter)) begin
                    next_state <= THIRTY_FIVE;
                end else begin
                    next_state <= TEN;
                end
            end
            FIFTEEN: begin
                if (i_nickle & (!i_dime) & (!i_quarter)) begin
                    next_state <= TWENTY;
                end else if ((!i_nickle) & (i_dime) & (!i_quarter)) begin
                    next_state <= TWENTY_FIVE;
                end else if ((!i_nickle) & (!i_dime) & (i_quarter)) begin
                    next_state <= FORTY;
                end else begin
                    next_state <= FIFTEEN;
                end
            end
            TWENTY: begin
                next_state <= INIT;
            end
            TWENTY_FIVE: begin
                next_state <= INIT;
            end
            THIRTY: begin
                next_state <= INIT;
            end
            THIRTY_FIVE: begin
                next_state <= INIT;
            end
            FORTY: begin
                next_state <= INIT;
            end
        endcase
    end

    // Output combinational logic
    always @(*) begin
        case (state)
            INIT: begin
                o_soda <= 1'b0;
                o_change <= 3'b000;
            end
            FIVE: begin
                o_soda <= 1'b0;
                o_change <= 3'b000;
            end
            TEN: begin
                o_soda <= 1'b0;
                o_change <= 3'b000;
            end
            FIFTEEN: begin
                o_soda <= 1'b0;
                o_change <= 3'b000;
            end
            TWENTY: begin
                o_soda <= 1'b1;
                o_change <= 3'b000;
            end
            TWENTY_FIVE: begin
                o_soda <= 1'b1;
                o_change <= 3'b001;
            end
            THIRTY: begin
                o_soda <= 1'b1;
                o_change <= 3'b010;
            end
            THIRTY_FIVE: begin
                o_soda <= 1'b1;
                o_change <= 3'b011;
            end
            FORTY: begin
                o_soda <= 1'b1;
                o_change <= 3'b100;
            end
        endcase
    end




endmodule