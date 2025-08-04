`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/04 18:15:21
// Design Name: 
// Module Name: register_file
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


module register_file #(parameter DATA_WIDTH = 8, DEPTH = 16)(
    input                       clk      ,
    input                       wr_en    ,
    input                       rd_en    ,
    input   [$clog2(DEPTH)-1:0] w_addr   ,
    input   [$clog2(DEPTH)-1:0] r_addr   ,
    input      [DATA_WIDTH-1:0] data_in  ,
    output reg [DATA_WIDTH-1:0] data_out 
    );

    // memory register
    reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];

    // sequential logic
    always @(posedge clk) begin
		// write enable일 때 입력
        if (wr_en) begin
            mem[w_addr] <= data_in;
        end
        // read enable일 때 출력
        if (rd_en) begin
            data_out <= mem[r_addr];
        end
    end
endmodule
