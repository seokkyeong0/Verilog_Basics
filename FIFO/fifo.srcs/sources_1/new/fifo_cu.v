`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/08/04 18:15:37
// Design Name: 
// Module Name: fifo_cu
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


module fifo_cu #(parameter DEPTH = 16)(
    input                      clk      ,
    input                      rst      ,
    input                      push     ,
    input                      pop      ,
    output [$clog2(DEPTH)-1:0] w_addr   ,
    output [$clog2(DEPTH)-1:0] r_addr   ,
    output                     full     ,
    output                     empty    
    );

    // register
    reg [$clog2(DEPTH)-1:0] w_ptr_reg, w_ptr_next;
    reg [$clog2(DEPTH)-1:0] r_ptr_reg, r_ptr_next;
    reg [$clog2(DEPTH):0]   c_ptr_reg, c_ptr_next;

    // output
    assign w_addr = w_ptr_reg;
    assign r_addr = r_ptr_reg;
    assign full  = (c_ptr_reg == DEPTH);
    assign empty = (c_ptr_reg == 0);

    // sequential logic
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            w_ptr_reg <= 0;
            r_ptr_reg <= 0;
            c_ptr_reg <= 0;
        end else begin
            w_ptr_reg <= w_ptr_next;
            r_ptr_reg <= r_ptr_next;
            c_ptr_reg <= c_ptr_next;
        end
    end

    // combinational logic
    always @(*) begin
        w_ptr_next = w_ptr_reg;
        r_ptr_next = r_ptr_reg;
        c_ptr_next = c_ptr_reg;

        case ({push, pop})
            // pop
            2'b01: begin
                if (!empty) begin
                    r_ptr_next = (r_ptr_reg == DEPTH - 1) ? 0 : r_ptr_reg + 1;
                    c_ptr_next = c_ptr_reg - 1;
                end
            end

            // push
            2'b10: begin
                if (!full) begin
                    w_ptr_next = (w_ptr_reg == DEPTH - 1) ? 0 : w_ptr_reg + 1;
                    c_ptr_next = c_ptr_reg + 1;
                end
            end 

            // push & pop
            2'b11: begin
                 if (empty) begin
                    w_ptr_next = (w_ptr_reg == DEPTH - 1) ? 0 : w_ptr_reg + 1;
                    c_ptr_next = c_ptr_reg + 1;
                 end else if (full) begin
                    r_ptr_next = (r_ptr_reg == DEPTH - 1) ? 0 : r_ptr_reg + 1;
                    c_ptr_next = c_ptr_reg - 1;
                end else begin
                    w_ptr_next = (w_ptr_reg == DEPTH - 1) ? 0 : w_ptr_reg + 1;
                    r_ptr_next = (r_ptr_reg == DEPTH - 1) ? 0 : r_ptr_reg + 1;
                    c_ptr_next = c_ptr_reg;
                end
            end  
        endcase
    end
endmodule