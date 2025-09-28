`timescale 1ns / 1ps

// Truth Table
// a | b | sum | carry
// 0   0    0      0
// 0   1    1      0
// 1   0    1      0
// 1   1    0      1

// sum is a XOR b
// carry is a AND b

module half_adder(
    input  logic a     ,
    input  logic b     ,
    output logic sum   ,
    output logic carry 
    );

    assign sum = a ^ b;
    assign carry = a & b;
endmodule
