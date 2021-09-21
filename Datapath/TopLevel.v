`timescale 1ns / 1ps

// Name: Braden Means, Brendan Yip, Emmanuel Enriquez
// Percent Effort: 33.3,33.3,33.3

module TopLevel(Clk, Reset, v0, v1);
    
    input Clk;
    input wire Reset;
    wire [31:0] PCResult,WriteData;
    output wire [31:0] v0, v1;
    wire [31:0] debug_s0;
    
    (* mark_debug = "true" *) wire [31:0] IDHi, IDLo;
    
    wire [31:0] Instruction, JumpMuxOutput,PCSrcOutput,
     outSL,outSE,ALUSrcMuxOutput,inSE,PCSrcMuxOutput, ALUSrc2MuxOuput, IDJumpAddress;
    wire [4:0] WriteRegister;
    wire [27:0] JumpAddress28;
    wire PCsrc,AndBEQ,AndBNE,PCWrite,IFIDWrite,ControlWrite;
    wire [1:0] IDJump;
    wire [31:0] IFPCAdderResult,IFInstruction;
    
    wire [31:0] IDReadData1, IDReadData2, IDSignExtension,IDPCAdderResult,
    IDHiLoSEMuxOutput;
    wire [4:0] IDrt,IDrd;
    wire IDOriSignal;
    
    wire [31:0] EXReadData1, EXReadData2, EXSignExtension,EXPCAdderResult,EXALUResult,
    EXAddResult,EXMult1,EXMult2,EXHiLoSEMuxOutput,EXLUI, EXJumpAddress,EXInstruction;
    wire [4:0] EXrt,EXrd;
    wire [5:0] EXOpBranch;
	wire [4:0] EXTwoBranch,EXSignExtendBits;
	wire [15:0] EXInstruction16;
	wire [1:0] EXJump;
	wire EXOriSignal;
    
    wire [31:0] MEMPCAdderResult,MEMAddResult,MEMALUResult,MEMReadData2,MEMReadData,MEMMult1,
    MEMMult2, MEMLUI, MEMInstruction,MEMJumpAddress;
    wire [63:0] MEMProduct;
    wire [1:0] MEMJump;
    
    wire [31:0] WBReadData,WBReadData2,WBALUResult,WBPCAdderResult,WBLUI;
    wire[63:0] WBProduct;
    
    
   // PIPELINE CONTROL SIGNALS
    wire IDMemWrite,IDMemRead,IDALUSrc,IDBranch,IDRegWrite,IDALUSrc2, IDBNE;
    wire EXMemWrite,EXMemRead,EXALUSrc,EXBranch,EXRegWrite,EXZero,EXALUSrc2,EXBNE;
    wire MEMMemWrite,MEMMemRead,MEMRegWrite,MEMBranch,MEMZero,MEMBNE;
    wire WBRegWrite;
    
    wire [4:0] IDALUOp,EXALUOp;
    wire [2:0] IDMemtoReg,EXMemtoReg,MEMMemtoReg,WBMemtoReg;
    wire [1:0] IDRegDst,EXRegDst;
    wire [1:0] IDHiLoSignal;
    wire [3:0] IDHiLoEnable;
    
    wire [4:0] EXRegDstMuxOut,MEMRegDstMuxOut,WBRegDstMuxOut;
    wire [3:0] EXHiLoEnable;
    
    wire [3:0] MEMHiLoEnable;
    
    wire [3:0] WBHiLoEnable;
    
    wire [4:0] EXrs;
    
    wire [31:0] AMuxOut, BMuxOut, MEMReadData1;
    
    wire WBMemRead;
    
    wire [1:0] MuxAControl, MuxBControl;
        
    wire FlushSignal;
    
    //Datapath Begins
    
    //Hazard Detection
    HazardDetection HD(PCWrite, IFIDWrite, ControlWrite, Instruction[25:21], 
        Instruction[20:16], EXrt, EXrd, EXMemRead, EXRegWrite, MEMRegDstMuxOut, 
        MEMRegWrite, EXReadData1, WBRegDstMuxOut, WBRegWrite,EXMemWrite,
        MEMMemWrite, Instruction[31:26], FlushSignal, PCsrc, MEMJump);
    
    Mux32Bit2To1 PCSrcMux(PCSrcMuxOutput, IFPCAdderResult, MEMAddResult,PCsrc); 
    Mux32Bit3To1 JumpMux(JumpMuxOutput, PCSrcMuxOutput, 
        MEMJumpAddress,MEMReadData1, MEMJump);

        
    ProgramCounter PC(JumpMuxOutput, PCResult, Reset, Clk, PCWrite);
    
    PCAdder Adder(PCResult, IFPCAdderResult); 
    InstructionMemory Im(PCResult, IFInstruction); 
   
    

    //IFID Pipeline Register
    IFIDRegister IFID(Clk,IFPCAdderResult, IDPCAdderResult, IFInstruction,
        Instruction, IFIDWrite, FlushSignal); 
  
    RegisterFile RF(Instruction[25:21], Instruction[20:16], WBRegDstMuxOut, 
        WriteData, WBRegWrite, Clk, IDReadData1,
         IDReadData2, v0, v1,debug_s0);
        
    //JumpAddress jump(IDPCAdderResult, Instruction,IDJumpAddress); 
    Controller Control(Instruction[31:26], Instruction[5:0], IDRegDst, IDRegWrite, IDALUSrc,
         IDALUOp, IDMemRead, IDMemWrite, IDMemtoReg, IDBranch, IDJump,IDALUSrc2,IDBNE,
         IDHiLoSignal,IDHiLoEnable, ControlWrite,FlushSignal,IDOriSignal);
    SignExtension SE(Instruction[15:0], inSE, IDOriSignal); 

    //Hi and Lo Registers initialized
    LoRegister lo(WBProduct, IDLo,WBHiLoEnable);
    HiRegister hi(WBProduct, IDHi,WBHiLoEnable);
    
    Mux32Bit3To1 HiLoSEMux(IDHiLoSEMuxOutput, inSE,IDLo,IDHi,IDHiLoSignal); 
    

    //IDEX Pipeline Register
    IDEXRegister IDEX(IDReadData1, IDReadData2, IDPCAdderResult,EXPCAdderResult, IDBranch, 
        EXBranch, 
        EXRegDst, EXALUOp, EXALUSrc, EXReadData1,EXReadData2, 
        Instruction[20:16], Instruction[15:11], EXrt, EXrd, 
        Clk, IDRegDst, IDALUOp, IDALUSrc, IDMemtoReg, EXMemtoReg, IDRegWrite, EXRegWrite,IDMemWrite,
        EXMemWrite,IDMemRead,EXMemRead,IDALUSrc2,EXALUSrc2,IDBNE,EXBNE,IDHiLoSEMuxOutput,
        EXHiLoSEMuxOutput,IDHiLoEnable,EXHiLoEnable,Instruction[31:26],EXOpBranch,Instruction[20:16],
        EXTwoBranch, Instruction[15:0], EXInstruction16,Instruction[10:6],EXSignExtendBits, Instruction[25:21], EXrs, FlushSignal,Instruction, EXInstruction,
        IDJump, EXJump);
        
    Mux32Bit3To1 AMux(AMuxOut, EXReadData1, MEMALUResult, WriteData, MuxAControl);
    Mux32Bit3To1 BMux(BMuxOut, EXReadData2, MEMALUResult, WriteData, MuxBControl);
        
    ForwardingUnit Forwarding(EXrt, EXrs, WBRegDstMuxOut, MEMRegDstMuxOut, 
        MEMRegWrite, WBRegWrite, MuxAControl, MuxBControl, WBMemRead);   
  
    
    ShiftLeft2 SL(EXHiLoSEMuxOutput,outSL);
    Adder getSum(EXPCAdderResult,outSL,EXAddResult);
    
    Mux32Bit2To1 ALUSrcMux(ALUSrcMuxOutput,BMuxOut, EXHiLoSEMuxOutput, EXALUSrc);
    Mux32Bit2To1 ALUSrc2Mux(ALUSrc2MuxOuput, AMuxOut, EXHiLoSEMuxOutput, EXALUSrc2);
    
    //EXHiLoRegFile EXHLRF(EXReadData1,EXReadData2,EXMult1,EXMult2);
    EXHiLoRegFile EXHLRF(ALUSrcMuxOutput,ALUSrc2MuxOuput,EXMult1,EXMult2);
    
    ALU32Bit MainALU(EXALUOp, ALUSrc2MuxOuput, ALUSrcMuxOutput, EXALUResult, EXZero,
        EXOpBranch,EXTwoBranch,EXSignExtendBits);
        
    Mux5Bit3To1 RegDstMux(EXRegDstMuxOut,EXrt,EXrd,31,
        EXRegDst);
        
    LeftShift16 LUIShift(EXInstruction16,EXLUI);
    
    //EXMEM Pipeline Register
    EXMEMRegister Ex(Clk, EXMemWrite, EXMemtoReg, EXBranch,MEMMemWrite, MEMMemtoReg,MEMBranch,EXAddResult, 
        MEMAddResult, EXZero,MEMZero, EXALUResult,MEMALUResult, BMuxOut,MEMReadData2,
        EXRegDstMuxOut,MEMRegDstMuxOut,EXPCAdderResult,MEMPCAdderResult,EXMemRead,MEMMemRead,
        EXRegWrite,MEMRegWrite,EXBNE,MEMBNE,EXMult1,EXMult2,MEMMult1,MEMMult2,EXHiLoEnable,
        MEMHiLoEnable,EXLUI,MEMLUI, FlushSignal, EXInstruction, MEMInstruction,EXJump,MEMJump, EXReadData1, MEMReadData1);  
    
    //For handling BEQ and BNE
    AndGate andGate(MEMBranch,MEMZero,AndBEQ);
    AndGate andGateBNE(MEMBNE,~(MEMZero),AndBNE);
    Or orPCSrc(AndBEQ,AndBNE, PCsrc);
    
    JumpAddress jump(MEMPCAdderResult, MEMInstruction,MEMJumpAddress); 
    
    
    DataMemory dataMem(MEMALUResult, MEMReadData2,Clk,MEMMemWrite,MEMMemRead,MEMReadData);
    
    MEMHiLoRegFile MEMHLRF(MEMMult1, MEMMult2,MEMProduct,MEMHiLoEnable);
    
   //MEMWB Pipeline Register
    MEMWB_Register memwbReg(Clk, MEMReadData,WBReadData,MEMALUResult,WBALUResult,
       MEMMemtoReg,MEMRegWrite,WBMemtoReg,WBRegWrite,MEMRegDstMuxOut,WBRegDstMuxOut,
        MEMPCAdderResult,WBPCAdderResult,MEMProduct,WBProduct,MEMHiLoEnable,
        WBHiLoEnable,MEMLUI,WBLUI, MEMMemRead, WBMemRead);
    

    // Actually a 5 to 1 Mux 
    Mux32Bit4To1 memToRegMux(WriteData,WBReadData,WBALUResult,WBPCAdderResult, 
        WBLUI, WBProduct, WBMemtoReg);       
       

endmodule
