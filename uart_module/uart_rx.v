`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/03 18:42:34
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input  clk              ,
    input  rst              ,
    input  rx               ,
    input  baud_tick        ,
    output [7:0] rx_data    ,
    output rx_busy          ,
    output rx_done          
    );

    // state parameter
    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;

    // register
    reg [1:0] state_reg, state_next;
    reg [7:0] rx_data_reg, rx_data_next;
    reg [3:0] tick_cnt_reg, tick_cnt_next;
    reg [2:0] bit_cnt_reg, bit_cnt_next;
    reg rx_busy_reg, rx_busy_next;
    reg rx_done_reg, rx_done_next;

    // output logic
    assign rx_data = rx_data_reg;
    assign rx_busy = rx_busy_reg;
    assign rx_done = rx_done_reg;

    // sequential logic
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state_reg    <= 0;
            rx_data_reg  <= 0;
            rx_busy_reg  <= 0;
            rx_done_reg  <= 0;
            bit_cnt_reg  <= 0;
            tick_cnt_reg <= 0;
        end else begin
            state_reg    <= state_next;
            rx_data_reg  <= rx_data_next;
            rx_busy_reg  <= rx_busy_next;
            rx_done_reg  <= rx_done_next;
            bit_cnt_reg  <= bit_cnt_next;
            tick_cnt_reg <= tick_cnt_next;
        end
    end

    // combinational logic
    always @(*) begin
        state_next    = state_reg;
        rx_data_next  = rx_data_reg;
        rx_busy_next  = rx_busy_reg;
        rx_done_next  = rx_done_reg;
        bit_cnt_next  = bit_cnt_reg;
        tick_cnt_next = tick_cnt_reg;
        case (state_reg)
            IDLE: begin
                rx_busy_next = 0;
                rx_done_next = 0;
                if (!rx) begin
                    rx_busy_next = 1;
                    state_next = START;
                end
            end
            START: begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 7) begin
                        rx_data_next = {rx, rx_data_reg[7:1]};
                        tick_cnt_next = 0;
                        state_next = DATA;
                    end
                end
            end 
            DATA: begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 15) begin
                        bit_cnt_next = bit_cnt_reg + 1;
                        rx_data_next = {rx, rx_data_reg[7:1]};
                        tick_cnt_next = 0;

                        if (bit_cnt_reg == 7) begin
                            bit_cnt_next = 0;
                            tick_cnt_next = 0;
                            state_next = STOP;
                        end
                    end
                end
            end 
            STOP: begin
                if (baud_tick) begin
                    tick_cnt_next = tick_cnt_reg + 1;
                    if (tick_cnt_reg == 15) begin
                        rx_busy_next = 0;
                        rx_done_next = 1;
                        state_next = IDLE;
                    end
                end
            end 
            default: state_next = state_reg;
        endcase
    end
endmodule
