`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/04 18:16:04
// Design Name: 
// Module Name: fifo
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


module fifo #(parameter DATA_WIDTH = 8, DEPTH = 16)(
    input                           clk     ,
    input                           rst     ,
    input                           push    ,
    input                           pop     ,
    input          [DATA_WIDTH-1:0] w_data  ,
    output         [DATA_WIDTH-1:0] r_data  ,
    output                          full    ,
    output                          empty   
    );

    wire [$clog2(DEPTH)-1:0] w_w_addr, w_r_addr;
    wire w_wr_en = push & ~full; // write 조건 (push 했는데 full이 아닐 때)
    wire w_rd_en = pop & ~empty; // read 조건 (pop 했는데 empty가 아닐 때)

    register_file #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) U_REG_FILE(
        .clk      (clk),
        .wr_en    (w_wr_en),
        .rd_en    (w_rd_en),
        .w_addr   (w_w_addr),
        .r_addr   (w_r_addr),
        .data_in  (w_data),
        .data_out (r_data)
    );

    fifo_cu #(.DEPTH(DEPTH)) U_FIFO_CU(
        .clk      (clk),
        .rst      (rst),
        .push     (push),
        .pop      (pop),
        .w_addr   (w_w_addr),
        .r_addr   (w_r_addr),
        .full     (full),
        .empty    (empty)
    );
endmodule
