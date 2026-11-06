`timescale 1ns / 1ps
/*
Implements a multiplexer that selects from two inputs (5 bits), a and b, based 
on the sel input. 
Its inputs are instrout_1511 and instrout_2016 from ID/EX latch, and regdst.
The output is muxout, which is sent to EX/MEM latch. 
*/
module bottom_mux(
    output wire [4:0] y,   // Output of Multiplexer
    input wire [4:0] a,    // Input 1 of Multiplexer
    input wire [4:0] b,    // Input 0 of Multiplexer
    input wire sel         // Select Input
);
   
    assign y = sel ? a : b;
    
endmodule // mux
