`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/03 18:42:49
// Design Name: 
// Module Name: uart
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


module uart(
    // clock & reset
    input        clk        ,
    input        rst        ,

    // tx module
    input        tx_start   ,
    input  [7:0] tx_data    ,
    output       tx         ,
    output       tx_busy    ,

    // rx module
    input        rx         ,
    output [7:0] rx_data    ,
    output       rx_busy    ,
    output       rx_done
    );

    wire w_b_tick;

    baud_tick #(.BAUD_RATE(9600)) U_BT_GEN(
        .clk          (clk),
        .rst          (rst),
        .baud_tick    (w_b_tick)
    );

    uart_tx U_UART_TX(
        .clk         (clk),
        .rst         (rst),
        .tx_start    (tx_start),
        .tx_data     (tx_data),
        .baud_tick   (w_b_tick),
        .tx          (tx),
        .tx_busy     (tx_busy)
    );

    uart_rx U_UART_RX(
        .clk              (clk),
        .rst              (rst),
        .rx               (rx),
        .baud_tick        (w_b_tick),
        .rx_data          (rx_data),
        .rx_busy          (rx_busy),
        .rx_done          (rx_done)
    );
endmodule
