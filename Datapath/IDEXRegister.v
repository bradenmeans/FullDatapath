`timescale 1ns / 1ps

module IDEXRegister(ReadData1in,ReadData2in,PCAdderIn,PCAdderOut,
    BranchIn,BranchOut,RegDst,ALUop,ALUSrc,
    ReadData1out,ReadData2out,RTin,RDin,RTout,RDout,Clk,RegDstIn,ALUopIn,ALUSrcIn,
    MemToRegIn,MemToRegOut,RegWriteIn,RegWriteOut,MemWriteIn,MemWriteOut,
    MemReadIn,MemReadOut,ALUSrc2In,ALUSrc2Out,BNEIn,BNEOut,inHiLoSE,outHiLoSE,
    inHiLoEnable,outHiLoEnable,OpBranchIn,OpBranchOut,TwoBranchIn,TwoBranchOut,
    inputImm,outputImm,inputSEBits,outputSEBits, RSin, RSout, FlushSignal
    ,inInstr,outInstr,inJumpSig,outJumpSig);

    input [31:0]ReadData1in,ReadData2in,PCAdderIn,inHiLoSE;
    input [4:0]RTin,RDin, RSin;
    input [4:0] ALUopIn;
    input BranchIn,Clk,ALUSrcIn,RegWriteIn,MemReadIn,MemWriteIn,
    ALUSrc2In,BNEIn, FlushSignal;
    input [1:0] RegDstIn;
    input [2:0] MemToRegIn;
    input [3:0] inHiLoEnable;
    input [5:0] OpBranchIn;
	input [4:0] TwoBranchIn;
	input [15:0] inputImm;
	input [4:0] inputSEBits;
    input [31:0] inInstr;
    input [1:0] inJumpSig;
    
    
    output [31:0]ReadData1out,ReadData2out,PCAdderOut,outHiLoSE;
    output [4:0] RTout,RDout, RSout;
    output [4:0] ALUop;
    output [1:0] RegDst;
    output [2:0] MemToRegOut;
    output  ALUSrc,BranchOut,RegWriteOut,
        MemReadOut,MemWriteOut,ALUSrc2Out,BNEOut;
    output  [3:0] outHiLoEnable;
    output [5:0] OpBranchOut;
	output [4:0] TwoBranchOut;
	output [15:0] outputImm;
	output [4:0] outputSEBits;
	output [31:0] outInstr;
	output [1:0] outJumpSig;
	

 reg [31:0] Register [25:0];
 
    initial begin 
        Register[0] <= 0;
        Register[1] <= 0;
        Register[2] <= 0;
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
        Register[3] <= 0;
        Register[16] <= 0;
        Register[17] <= 0;
        Register[18] <= 0;
        Register[19] <= 0;
        Register[20] <= 0;
        Register[21] <= 0;
        Register[22] <= 0;
        Register[23] <= 0;
        Register[24] <= 0;
       
     end 

    always @(posedge Clk) begin
    
    if (FlushSignal == 1) begin
        
        Register[0] <= 0;
        Register[1] <= 0;
        Register[2] <= 0;
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
        Register[3] <= 0;
        Register[16] <= 0;
        Register[17] <= 0;
        Register[18] <= 0;
        Register[19] <= 0;
        Register[20] <= 0;
        Register[21] <= 0;
        Register[22] <= 0;
        Register[23] <= 0;
        Register[24] <= 0;
        
    
    end 
    
   else begin
    
        Register[0] <= ReadData1in;
        Register[1] <= ReadData2in;
        Register[2] <= PCAdderIn;
        Register[4] <= RTin;
        Register[5] <= RDin;
        Register[6] <= BranchIn;
        Register[7] <= MemToRegIn;
        Register[8] <= RegWriteIn;
        Register[9] <= RegDstIn;
        Register[10] <= ALUopIn;
        Register[11] <= ALUSrcIn;
        Register[12] <= MemReadIn;
        Register[13] <= MemWriteIn;
        Register[14] <= ALUSrc2In;
        Register[15] <= BNEIn;
        Register[3] <= inHiLoSE;
        Register[16] <= inHiLoEnable;
        Register[17] <= OpBranchIn;
        Register[18] <= TwoBranchIn;
        Register[19] <= inputImm;
        Register[20] <= inputSEBits;
        Register[22] <= RSin;
        Register[23] <= inInstr;
        Register[24] <= inJumpSig;
        //Register[25] <= inOri;
        
      end  

    end
    
    assign ReadData1out = Register[0];
    assign ReadData2out = Register[1];
    assign PCAdderOut = Register[2];
    assign RTout = Register[4];
    assign RDout = Register[5];
    assign BranchOut = Register[6];
    assign MemToRegOut = Register[7];
    assign RegWriteOut = Register[8];
    assign RegDst = Register[9];
    assign ALUop = Register[10];
    assign ALUSrc = Register[11];
    assign MemReadOut = Register[12];
    assign MemWriteOut = Register[13];
    assign ALUSrc2Out = Register[14];
    assign BNEOut = Register[15];
    assign outHiLoSE = Register[3];
    assign outHiLoEnable = Register[16]; 
    assign OpBranchOut = Register[17];
    assign TwoBranchOut = Register[18];
    assign outputImm = Register[19];
    assign outputSEBits = Register[20];
    assign RSout = Register[22];
    assign outInstr = Register[23];
    assign outJumpSig = Register[24];
    //assign outOri = Register[25];
endmodule