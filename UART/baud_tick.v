`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/03 18:41:56
// Design Name: 
// Module Name: baud_tick
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


module baud_tick #(BAUD_RATE = 9600)(
        input  clk          ,
        input  rst          ,
        output baud_tick    
    );

    // parameter
    parameter DIV = 100_000_000 / (BAUD_RATE * 16);

    // register
    reg [$clog2(DIV)-1:0] count;
    reg tick;

    // output
    assign baud_tick = tick;

    // sequential logic
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            tick  <= 1'b0;
            count <= 0;
        end else begin
            if (count == DIV - 1) begin
                tick  <= 1'b1;
                count <= 0;
            end else begin
                tick  <= 1'b0;
                count <= count + 1;
            end
        end
    end
endmodule
