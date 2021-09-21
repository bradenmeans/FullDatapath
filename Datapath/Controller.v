`timescale 1ns / 1ps

module Controller(op, Funct, RegDst, RegWrite, ALUSrc, ALUop,
     MemRead, MemWrite, MemtoReg,  Branch,Jump,ALUSrc2,BNE,SELoHi,HiLoEnable, ControlWrite,
     FlushSignal,OriSignal);
    
    input ControlWrite;
    input [5:0] op;
    input [5:0] Funct;
    input FlushSignal;
    output reg  RegWrite, ALUSrc, MemRead, MemWrite,  
       Branch,ALUSrc2, BNE, OriSignal;
    output reg [4:0] ALUop;
    output reg [1:0] RegDst,Jump, SELoHi;
    output reg [2:0] MemtoReg;
    output reg [3:0] HiLoEnable;
    
    initial begin 
       ALUSrc <= 0;
       ALUSrc2 <=0;
	   RegDst <= 0;
	   RegWrite <= 0;
	   MemRead <= 0;
	   //PCSrc <=0;
	   MemWrite <= 0;
	   MemtoReg <= 0;
	   Branch <= 0;
	   BNE <= 0;
	   Jump <= 0;
	   ALUop <= 4'b0000;
	   SELoHi<=0;
	   HiLoEnable <= 0;
	end 
    
    always @(op,Funct, ControlWrite,FlushSignal) begin 
    
    if (ControlWrite == 1) begin
       ALUSrc <= 0;
       ALUSrc2 <=0;
	   RegDst <= 0;
	   RegWrite <= 0;
	   MemRead <= 0;
	   MemWrite <= 0;
	   MemtoReg <= 0;
	   Branch <= 0;
	   BNE <= 0;
	   Jump <= 0;
	   ALUop <= 4'b0000;
	   SELoHi<=0;
	   HiLoEnable <= 0;
	   OriSignal <=0;
    end
    else if (FlushSignal == 1) begin
        Jump <=0;
    end
    
    else begin
    
	if (op == 6'b000000) begin // R-type instruction
	ALUSrc <= 0;
	RegDst <= 1;
	RegWrite <= 1;
	MemRead <= 0;
	//PCSrc <=0;
	MemWrite <= 0;
	MemtoReg <= 1;
	Branch <= 0;
	BNE <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
		if (Funct == 6'b100000) begin // Add
			ALUop <= 4'b0000;
		end
		if (Funct == 6'b100010) begin // Subtract (sub)
			ALUop <= 4'b0001;
		end
		if (Funct == 6'b100100) begin // And
			ALUop <= 4'b0011;
		end
		if (Funct == 6'b100101) begin // Or
			ALUop <= 4'b0100;
		end
		if (Funct == 6'b101010) begin // SLT
			ALUop <= 4'b0101;
		end
		if (Funct == 6'b000000) begin // SLL
		ALUSrc2 <=1;
		ALUop <= 4'b1000;
		end
		if (Funct == 6'b000010) begin // SRL and rotr
		ALUSrc2 <= 1;
			ALUop <= 4'b1001;
		end
		if (Funct == 6'b000110) begin // SRLV and rotrv
			ALUop <= 4'b1111;
		end
	    if (Funct == 6'b100001) begin // Add unsigned (addu)
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b100111) begin // Nor
			ALUop <= 4'b1110; 
		end
        if (Funct == 6'b101011) begin // SLT unsigned (sltu)
			ALUop <= 4'b0101; 
		end
	    if (Funct == 6'b100110) begin // Exclusive or (xor)
			ALUop <= 4'b1011;
		end
	    if (Funct == 6'b000100) begin // SLLV
			ALUop <= 4'b0010;
		end
	    if (Funct == 6'b000011) begin // SRA
			ALUop <= 5'b10010; 
			ALUSrc2 <= 1;
		end
	    if (Funct == 6'b000111) begin // SRAV
			ALUop <= 5'b10011; 
		end
	    if (Funct == 6'b010000) begin // MFHI
	       // SELoHi <= 2;
	        //ALUSrc <= 1;
	        MemtoReg <= 4;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b010010) begin // MFLO
	        //SELoHi <=1;
	        //ALUSrc <=1;
	        MemtoReg <= 4;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b010001) begin // MTHI
	       RegWrite <= 0;
	       HiLoEnable <= 2;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b010011) begin // MTLO
	    RegWrite <= 0;
	    HiLoEnable <= 1;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b011000) begin // Multiply word (mult)
	        RegWrite <= 0;
	        HiLoEnable <= 3;
			ALUop <= 4'b0010; 
		end
	    if (Funct == 6'b011001) begin // Multiply unsigned
	    RegWrite <= 0;
	    HiLoEnable <= 3;
			ALUop <= 4'b0010; 
		end
	    if (Funct == 6'b001000) begin // JR
	       Jump <= 2;
	       RegWrite <= 0;
	       MemWrite <= 0;
	       MemtoReg <= 2;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b001011) begin // Move conditional on not zero (movn)
			ALUop <= 5'b10000; 
		end
	    if (Funct == 6'b001010) begin // Move conditional on zero (movz)
			ALUop <= 5'b10001; 
		end

	end

    
	else if (op == 6'b011100) begin // Special reg 2
	ALUSrc <= 0;
	RegDst <= 1;
	RegWrite <= 1;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	BNE <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	/*
		if (Funct == 6'b100001) begin // 
			ALUop <= 4'b1011;
		end
		if (Funct == 6'b100000) begin // 
			ALUop <= 4'b1100;
		end */
		if (Funct == 6'b000010) begin // mul
	    //SELoHi<=1;
		HiLoEnable <= 3;
	    //ALUSrc <= 1;
		ALUop <= 5'b10100; 
		//ALUop <= 4'b0000;
		MemtoReg <= 4;
			
		end 
	   	if (Funct == 6'b000000) begin // Multiply and add word to hi,lo (madd)
	   	   HiLoEnable <=4;
			ALUop <= 4'b0000; 
		end
	    if (Funct == 6'b000100) begin // Multiply and subtract word to hi,lo (msub)
			ALUop <= 4'b0001; 
			HiLoEnable <=5;
		end
	end 
	
    else if (op == 6'b011111) begin // Special reg 3 (WIP)
	ALUSrc <= 0;
	ALUSrc2 <=0;
	RegDst <= 0;
	RegWrite <= 1;
	BNE <= 0;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	SELoHi <= 0;
	HiLoEnable <= 0;
	OriSignal <=0;
		if (Funct == 6'b100000) begin // Sign-extend halfword (seh)
			ALUop <= 4'b1000; 
		end
		if (Funct == 6'b100000) begin // Sign-extend byte (seb)
			ALUop <= 4'b1000; 
		end
	end 


    else if (op == 6'b001000) begin //ADDI
	ALUSrc <= 1;
	RegDst <= 0;
	ALUSrc2 <=0;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 0;
	BNE <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b001001) begin //ADDIU
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 0;
	ALUSrc2 <=0;
	MemtoReg <= 1;
	BNE <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b001100) begin //ANDI
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	BNE <= 0;
	ALUop <= 4'b0011;
	MemRead <= 0;
	MemWrite <= 0;
	ALUSrc2 <=0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000100) begin //BEQ
	ALUSrc <= 0;
	RegDst <= 0;
	ALUSrc2 <=0;
	BNE <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	//PCSrc <= 1;
	Branch <= 1;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
    
    else if (op == 6'b000001) begin //BGEZ
	ALUSrc <= 0;
	RegDst <= 0;
	RegWrite <= 0;
	ALUSrc2 <=0;
	BNE <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	//PCSrc <= 1;
	Branch <= 1;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;	
	end
	
	else if (op == 6'b000111) begin //BGTZ
	ALUSrc <= 0;
	RegDst <= 0;
	ALUSrc2 <=0;
	BNE <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	//PCSrc <= 1;
	Branch <= 1;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000110) begin //BLEZ
	ALUSrc <= 0;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	BNE <= 0;
	//PCSrc <= 1;
	Branch <= 1;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000001) begin //BLTZ
	ALUSrc <= 0;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	BNE <= 0;
	MemtoReg <= 0;
	//PCSrc <= 1;
	Branch <= 1;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b100000) begin //LB
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 1;
	BNE <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	ALUSrc2 <=0;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b100001) begin //LH
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 1;
	BNE <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	ALUSrc2 <=0;
	Jump <= 0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
    
    else if (op == 6'b001111) begin //LUI
	ALUSrc <= 0;
	RegDst <= 0;
	RegWrite <= 1;
	BNE <= 0;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 3;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b101000) begin //SB
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 1;
	MemtoReg <= 0;
	BNE <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b001010) begin //SLTI
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0101;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	BNE <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b001011) begin //SLTIU
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0101;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 1;
	BNE <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b101001) begin //SH
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 1;
	MemtoReg <= 0;
	BNE <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b001110) begin //XORI
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b1011;
	MemRead <= 0;
	MemWrite <= 0;
	BNE <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=1;
	end
	
	else if (op == 6'b001101) begin //ORI
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0100;
	MemRead <= 0;
	MemWrite <= 0;
	BNE <= 0;
	MemtoReg <= 1;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=1;
	end
	
	else if (op == 6'b100011) begin //LW
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 1;
	MemWrite <= 0;
	BNE <= 0;
	MemtoReg <= 0;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b101011) begin //SW
	ALUSrc <= 1;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 1;
	MemtoReg <= 0;
	//PCSrc <= 0;
	BNE <= 0;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000101) begin //BNE
	ALUSrc <= 0;
	RegDst <= 0;
	RegWrite <= 0;
	ALUop <= 4'b0001;
	MemRead <= 0;
	MemWrite <= 0;
	MemtoReg <= 0;
	BNE <= 1;
	//PCSrc <= 1;
	Branch <= 0;
	Jump <= 0;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000011) begin // JAL
    ALUSrc <= 0;
	RegDst <= 2;
	RegWrite <= 1;
	ALUop <= 4'b0000;
	MemRead <= 0;
	MemWrite <= 0;
	BNE <= 0;
	MemtoReg <= 2;
	//PCSrc <= 0;
	Branch <= 0;
	Jump <= 1;
	ALUSrc2 <=0;
	SELoHi<=0;
	HiLoEnable <= 0;
	OriSignal <=0;
	end
	
	else if (op == 6'b000010) begin // Jump
    ALUSrc <= 0;
    ALUSrc2 <=0;
    RegDst <= 0;
    RegWrite <= 0;
    ALUop <= 4'b0000;
    MemRead <= 0;
    MemWrite <= 0;
    MemtoReg <= 0;
    //PCSrc <= 0;
    BNE <= 0;
    Branch <= 0;
    Jump <= 1;
    SELoHi<=0;
    HiLoEnable <= 0;
    OriSignal <=0;
    end
    
    end
end
endmodule

