`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/03 18:42:14
// Design Name: 
// Module Name: uart_tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tx(
    input        clk         ,
    input        rst         ,
    input        tx_start    ,
    input  [7:0] tx_data     ,
    input        baud_tick   ,
    output       tx          ,
    output       tx_busy     
    );

    // state parameter
    parameter IDLE = 0, WAIT = 1, START = 2, DATA = 3, STOP = 4;

    // register
    reg [2:0] state_reg, state_next;
    reg [3:0] tick_cnt_reg, tick_cnt_next;
    reg [2:0] bit_cnt_reg, bit_cnt_next;
    reg tx_reg, tx_next;
    reg tx_busy_reg, tx_busy_next;

    // output logic
    assign tx = tx_reg;
    assign tx_busy = tx_busy_reg;
    
    // sequential logic
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state_reg <= 0;
            tick_cnt_reg <= 0;
            bit_cnt_reg <= 0;
            tx_reg <= 1;
            tx_busy_reg <= 0;
        end else begin
            state_reg <= state_next;
            tick_cnt_reg <= tick_cnt_next;
            bit_cnt_reg <= bit_cnt_next;
            tx_reg <= tx_next;
            tx_busy_reg <= tx_busy_next;
        end
    end

    // combinational logic (mealy FSM)
    always @(*) begin
        state_next = state_reg;
        tx_next = tx_reg;
        tx_busy_next = tx_busy_reg;
        tick_cnt_next = tick_cnt_reg;
        bit_cnt_next = bit_cnt_reg;
        case (state_reg)
            IDLE : begin
                tx_next = 1;
                tx_busy_next = 0;
                if (tx_start) begin
                    state_next = WAIT;
                end
            end
            WAIT : begin
                if (baud_tick) begin
                    tx_next = 0;
                    tx_busy_next = 1;
                    state_next = START; 
                end
            end 
            START: begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 15) begin
                        tick_cnt_next = 0;
                        tx_next = tx_data[bit_cnt_reg];
                        state_next = DATA;
                    end
                end
            end
            DATA : begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 15) begin
                        tx_next = tx_data[bit_cnt_reg + 1];
                        bit_cnt_next = bit_cnt_reg + 1;
                        tick_cnt_next = 0;

                        if (bit_cnt_reg == 7) begin
                            tx_next = 1;
                            bit_cnt_next = 0;
                            state_next = STOP;
                        end
                    end
                end
            end 
            STOP : begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 15) begin
                        tx_busy_next = 0;
                        tick_cnt_next = 0;
                        state_next = IDLE;
                    end
                end
            end
            default: state_next = state_reg;
        endcase
    end
endmodule
