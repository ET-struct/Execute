`timescale 1ns / 1ps
module alu_control(
    input wire [5:0] funct, //from ID/EX latch
    input wire [1:0] aluop,
    output reg [2:0] select
    );
    //These are the function field paramters for Rtype.
// ALU Op
parameter Rtype =  2'b10,
          lwsw = 2'b00,
          Itype = 2'b01; 
 
// ALU Control Inputs Designation
parameter ALUadd = 3'b010,  //for R-type instructions
ALUsub = 3'b110,
ALUand = 3'b000,
ALUor = 3'b001,
ALUslt = 3'b111;
 
parameter unknown = 2'b11, //for invalid opcode, ALUop = 2'b11
ALUx = 3'b011;
// Funct Field
parameter FUNCTadd = 6'b100000,
          FUNCTsub = 6'b100010,
          FUNCTand = 6'b100100,
          FUNCTor = 6'b100101,
          FUNCTslt = 6'b101010;

always@* begin
if (aluop == Rtype) begin
case(funct)
//assign the correct select value based on the function field.
// Desired ALU action
          FUNCTadd: select <= ALUadd;
          FUNCTsub: select <= ALUsub;
          FUNCTand: select <= ALUand;
          FUNCTor: select <= ALUor;
          FUNCTslt: select <= ALUslt;
          default: select <= ALUx;
          endcase
          end
 
//Feel free to reuse any of the paramters defined above.
//Not sure about this part 
else if (aluop == lwsw)
        select = ALUadd;
else if (aluop == Itype)
        select = ALUsub;
else if (aluop == unknown)
    begin
    select = ALUx;
end
end
endmodule
