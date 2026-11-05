`timescale 1ns / 1ps
/*
Implements a multiplexer that selects from two 32-bit inputs, a and b, based 
on the sel input (ALUSrc). 
Its inputs are ReadData2 (input 0) and the SignExtend value (input 1). 
The output goes to the ALU. 
*/
module top_mux(
    output wire [31:0] y,  // Output to ALU
    input wire [31:0] a,   // Input 1 (SignExtend)
    input wire [31:0] b,   // Input 0 (ReadData2)
    input wire sel         // Select Input (ALUSrc)
);
   
    assign y = sel ? a : b;
    
endmodule
