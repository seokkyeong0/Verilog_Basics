`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/04 19:18:04
// Design Name: 
// Module Name: tb_fifo
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


module tb_fifo();

    parameter DATA_WIDTH = 8;
    parameter DEPTH = 4;

    reg clk, rst, push, pop;
    reg [DATA_WIDTH-1:0] w_data;
    wire [DATA_WIDTH-1:0] r_data;
    wire full, empty;

    // DUT 인스턴스
    fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) DUT (
        .clk(clk),
        .rst(rst),
        .push(push),
        .pop(pop),
        .w_data(w_data),
        .r_data(r_data),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        $display("==== FIFO Test Start ====");
        $dumpfile("tb_fifo.vcd"); // GTKWave 보기 위한 dump
        $dumpvars(0, tb_fifo);

        clk = 0;
        rst = 1;
        push = 0;
        pop = 0;
        w_data = 0;

        // Reset 상태
        #10;
        rst = 0;
        #10;

        // Push 하나
        push = 1;
        w_data = 8'hAA;
        #10;
        push = 0;

        // Pop 하나
        pop = 1;
        #10;
        pop = 0;

        // 연속 push (FIFO full test)
        push = 1;
        repeat (DEPTH + 2) begin
            w_data = $random % 256;
            #10;
        end
        push = 0;

        // 연속 pop (FIFO empty test)
        pop = 1;
        repeat (DEPTH + 2) begin
            #10;
        end
        pop = 0;

        // Push & pop 동시에
        push = 1;
        pop = 1;
        w_data = 8'h55;
        #10;
        w_data = 8'h56;
        #10;
        w_data = 8'h57;
        #10;
        push = 0;
        pop = 0;

        // Full 상태에서 push 시도
        push = 1;
        repeat (DEPTH) begin
            w_data = $random % 256;
            #10;
        end
        w_data = 8'hFF; // 한 번 더 밀어넣기 (무시되어야 함)
        #10;
        push = 0;

        // Empty 상태에서 pop 시도
        pop = 1;
        repeat (DEPTH + 1) begin
            #10;
        end
        pop = 0;

        #20;
        $display("==== FIFO Test Finished ====");
        $finish;
    end
endmodule
