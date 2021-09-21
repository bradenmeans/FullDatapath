`timescale 1ns / 1ps
module EXMEMRegister(Clk, inputMemWrite, inputMemtoReg, inputPCSrc, outputMemWrite, 
    outputMemtoReg, outputPCSrc, inputAddResult, outputAddResult,
    inputALUZero, outputALUZero, inputALUResult, outputALUResult, 
    inputReadData2, outputReadData2, inputBottomMux, outputBottomMux,PCplus4In,PCplus4Out,
    inpMemRead,outMemRead,inpRegWrite,outRegWrite,inBNE,outBNE,inMult1,inMult2,outMult1,
    outMult2,inHiLoEnable,outHiLoEnable, ShiftLeft16In, ShiftLeft16Out, FlushSignal,
    inInstr, outInstr,inJumpSig,outJumpSig, inReadData1, outReadData1);

    input Clk, FlushSignal;

    input inputMemWrite,inputPCSrc,inBNE;
    output  outputMemWrite,  outputPCSrc,outBNE;
    
    input [2:0] inputMemtoReg;
    output [2:0] outputMemtoReg;

    input [31:0] inputAddResult, inReadData1;
    output [31:0] outputAddResult, outReadData1;

    input inputALUZero;
    output outputALUZero;

    input [31:0] inputALUResult;
    output  [31:0] outputALUResult;

    input [31:0] inputReadData2;
    output  [31:0] outputReadData2;

    input [4:0] inputBottomMux;
    output [4:0] outputBottomMux;

    input [31:0] PCplus4In;
    output [31:0]PCplus4Out;
    
    input [31:0] inMult1, inMult2;
    output [31:0] outMult1, outMult2;
    
    input [3:0] inHiLoEnable;
    output [3:0] outHiLoEnable;
    
    input [31:0] ShiftLeft16In;
    output [31:0] ShiftLeft16Out;
    
    input [31:0] inInstr;
    output [31:0] outInstr;
    
    
    input [1:0] inJumpSig;
    output [1:0] outJumpSig;
    
  reg [31:0] Register [19:0];
  
  input inpMemRead;
  output  outMemRead;
  
  input inpRegWrite;
  output  outRegWrite;
  
     initial begin 
        Register[0] <= 0;
        Register[1] <= 0;
        Register[2] <= 0;
        Register[3] <= 0;
        Register[4] <= 0;
        Register[5] <= 0;
        Register[6] <= 0;
        Register[7] <= 0;
        Register[8] <= 0;
        Register[9] <= 0;
        Register[10] <= 0;
        Register[11] <= 0;
        Register[12] <= 0;
        Register[13] <= 0;
        Register[14] <= 0;
        Register[15] <= 0;
        Register[16] <= 0;
        Register[17] <= 0;
        Register[18] <= 0;

   
     end 

    always @(posedge Clk) begin
    
    if (FlushSignal == 1) begin
        
        Register[0] <= 0;
        Register[1] <= 0;
        Register[2] <= 0;
        Register[3] <= 0;
        Register[4] <= 0;
        Register[5] <= 0;
        Register[6] <= 0;
        Register[7] <= 0;
        Register[8] <= 0;
        Register[9] <= 0;
        Register[10] <= 0;
        Register[11] <=0;
        Register[12] <=0;
        Register[13] <=0;
        Register[14] <= 0;
        Register[15] <= 0;
        Register[16] <= 0;
        Register[17] <= 0;
        Register[18] <= 0;
        Register[19] <= 0;

        
    end 
    
    else begin 
    
    Register[0] <= inputMemWrite;
    Register[1] <= inputMemtoReg;
    Register[2] <= inputPCSrc;

    Register[3] <= inputAddResult;

    Register[4] <= inputALUZero;

    Register[5] <= inputALUResult;

    Register[6] <= inputReadData2;

    Register[7] <= inputBottomMux;
    Register[8] <= PCplus4In;
    Register[9] <= inpMemRead;
    Register[10] <= inpRegWrite;
    Register[11] <= inBNE;
    Register[12] <= inMult1;
    Register[13] <= inMult2;
    Register[14] <= inHiLoEnable;
    Register[15] <= ShiftLeft16In;
    Register[16] <= inInstr;
    Register[18] <= inJumpSig;
    Register[19] <= inReadData1;

    
    end

    end
    
    
    assign outputMemWrite = Register[0];
    assign outputMemtoReg = Register[1];
    assign outputPCSrc = Register[2];
    assign outputALUZero = Register[4];
    assign outputAddResult = Register[3];
    assign outputALUResult = Register[5];
    assign outputReadData2 = Register[6];
    assign outputBottomMux = Register[7];
    assign PCplus4Out = Register[8];
    assign outMemRead = Register[9];
    assign outRegWrite = Register[10]; 
    assign outBNE = Register[11];
    assign outMult1 = Register[12];
    assign outMult2 = Register[13];
    assign outHiLoEnable = Register[14];
    assign ShiftLeft16Out = Register [15];
    assign outInstr = Register[16];
    assign outJumpSig = Register[18];
    assign outReadData1 = Register[19];
    
endmodule