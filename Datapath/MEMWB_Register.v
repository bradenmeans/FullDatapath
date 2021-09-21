`timescale 1ns / 1ps
module MEMWB_Register(Clk,readData,oData,ALUResult,OALUResult,
    MemtoReg,RegWrite,oMemtoReg,oRegWrite,RegDstMuxOutIn, RegDstMuxOutOut, inputPCPlus4, 
    outputPCPlus4,inputProduct,outputProduct,inHiLoEnable,outHiLoEnable,inLUI,
    outLUI,inMemRead, outMemRead);
 
 input Clk;
 input inMemRead;
 output outMemRead;
 input [31:0] readData;
 output  [31:0] oData;
 input [31:0] ALUResult;
 output [31:0] OALUResult;
 input [31:0] inputPCPlus4;
 output [31:0] outputPCPlus4;
 input RegWrite;
 input [2:0] MemtoReg;
 output  oRegWrite;
 output  [2:0] oMemtoReg;
 input [4:0] RegDstMuxOutIn;
 output [4:0] RegDstMuxOutOut;
 input [63:0] inputProduct;
 output [63:0] outputProduct;
 input [3:0] inHiLoEnable;
 output [3:0] outHiLoEnable;
 input [31:0] inLUI;
 output[31:0] outLUI;
 
 reg [31:0] Register [8:0];
 reg [63:0] HiLoRegister;
 
     initial begin 
        Register[0] <= 0;
        Register[1] <= 0;
        Register[2] <= 0;
        Register[3] <= 0;
        Register[4] <= 0;
        Register[5] <= 0;
        HiLoRegister <= 0;
        Register[6] <= 0;
        Register[7] <= 0;
        Register[8] <= 0;
     end 
 
 always @(posedge Clk) begin
 /*
 OALUResult = ALUResult;
 oData = readData;
 outputPCPlus4= inputPCPlus4;
 oMemtoReg = MemtoReg;
 oRegWrite = RegWrite;
 RegDstMuxOutOut = RegDstMuxOutIn;
 outputProduct = inputProduct;
 outHiLoEnable = inHiLoEnable; */
 
 //end
 
// always @(negedge Clk) begin
 
Register[0] <= ALUResult;
Register[1] <= readData;
Register[2] <= inputPCPlus4;
 Register[3] <= MemtoReg;
Register[4] <= RegWrite;
Register[5] <= RegDstMuxOutIn;
Register[6] <= inHiLoEnable;
HiLoRegister <= inputProduct;
Register[7] <= inLUI;
Register[8] <= inMemRead;
 
 end
 
 
 assign OALUResult = Register[0];
 assign oData = Register[1];
assign outputPCPlus4 = Register[2];
 assign oMemtoReg = Register[3];
 assign oRegWrite = Register[4];
 assign RegDstMuxOutOut = Register[5];
 assign outputProduct = HiLoRegister;
 assign outHiLoEnable = Register[6];
 assign outLUI = Register[7];
 assign outMemRead = Register[8];

endmodule
