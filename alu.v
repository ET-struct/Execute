`timescale 1ns / 1ps
module alu(
    input wire [31:0] a, // source from register
    input wire [31:0] b, // target from register
    input wire [2:0] control,// select from alu_control
    output reg [31:0] result, // goes to MEM Data memory and MEM/WB latch
    output wire zero // goes to MEM Branch
    );
    // Based on Lab 3-2 Instruction Operation and ALU control
parameter ALUadd = 3'b010,
ALUsub = 3'b110,
ALUand = 3'b000,     
ALUor = 3'b001,
ALUslt = 3'b111;
// Handles negative inputs
wire sign_mismatch; // 1 bit
//assign sign_mismatch = 1'b0; // Set this up so that the ALUslt conditions match
assign sign_mismatch = a[31]^b[31]; //XOR operation; only returns 1 if bits are different 
initial
result <= 0;
always@*
case(control)
ALUadd: result = a + b;
ALUsub: result = a - b;
ALUand: result = a & b; // changed to bit-wise AND, should not be logical AND
ALUor: result = a | b; // changes to bit-wise OR,  should not be logical OR
ALUslt: result = a < b ? 1 - sign_mismatch : 0 + sign_mismatch; // (0)
default: result = 32'bX; // control = ALUx | *
endcase

assign zero = (result == 0) ? 1 : 0;
endmodule
