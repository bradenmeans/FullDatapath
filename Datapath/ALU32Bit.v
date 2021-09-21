`timescale 1ns / 1ps
//DONEEEEE
////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
// 
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B)))
//  
//
// 
////////////////////////////////////////////////////////////////////////////////

/*module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
    
	output reg [31:0] ALUResult;
	//output reg [31:0] ALUResultHi;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	
    
    integer counter, i;
    reg [63:0] temp;
    reg [31:0] Lo;
    reg [31:0] Hi;
   
    always@(ALUControl, A, B) begin
        counter = 0;
        Zero = 0;
        if(ALUControl == 4'b0000) begin // add
            ALUResult <= A+B; end
        else if (ALUControl == 4'b0001) begin // sub
            ALUResult <= A-B;
            if ((A-B) == 0) begin
                Zero = 1;
            end
        end
        else if (ALUControl == 4'b0010) begin // multiply
            temp <= A*B;
            if ((temp > 2147483647) | (temp < -2147483647)) begin
                ALUResult <= temp[31:0];
                Lo <= temp[31:0];
                Hi <= temp[63:32];
                //ALUResultHi <= temp[63:32]; 
                end
            else
                ALUResult <= temp[31:0]; end
        else if (ALUControl == 4'b0011) begin // and
            ALUResult <= A & B; end
        else if (ALUControl == 4'b0100) begin // or
            ALUResult <= A|B; end
        else if (ALUControl == 4'b0101) begin // less than
            ALUResult <= (A<B); end
        else if (ALUControl == 4'b0110) begin // equal 
            ALUResult <= (A==B); end //DOUBLE CHECK IF THIS IS THE DESIRED OUTPUT
        else if (ALUControl == 4'b0111) begin // not equal
            ALUResult <= (A!=B); end
        else if (ALUControl == 4'b1000) begin // shift left
            ALUResult <= (B<<A[10:6]); end
        else if (ALUControl == 4'b1001) begin // shift right
            ALUResult <= (B>>A[10:6]); end
        else if (ALUControl == 4'b1010) begin 
            ALUResult <= ((A >> B) | (A << (32-B))); end
        else if (ALUControl == 4'b1011) begin // xor
            ALUResult <= A^B; end
        else if (ALUControl == 4'b1110) begin
            ALUResult <= ~(A|B); end
        end
            
 
endmodule */
module ALU32Bit(ALUControl, A, B, ALUResult, Zero, BranchOp, TwoBranch,SEBits);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
	input [5:0] BranchOp;
	input [4:0] TwoBranch,SEBits;
    
	output reg [31:0] ALUResult;
	//output reg [31:0] ALUResultHi;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
	
	
    
    integer counter, i;
    reg [63:0] temp;
    reg [31:0] Lo;
    reg [31:0] Hi;
   
    always@(*) begin
        counter <= 0;
        Zero <= 0;
        
        if ((BranchOp == 6'b000111) || (BranchOp == 6'b000110) || (BranchOp == 6'b000001) || (BranchOp == 6'b000100) || (BranchOp == 6'b000101)) begin 
            
            if (BranchOp == 6'b000111) begin //BGTZ
                if ($signed(A) > 0) begin
                    Zero <= 1;
                end
            end
            
            if (BranchOp == 6'b000110) begin //BLEZ
                if ($signed(A) <= 0) begin
                    Zero <= 1;
                end
            end
            
            if (BranchOp == 6'b000001) begin //BLTZ or BGEZ 
                if (TwoBranch == 5'b00000) begin //BLTZ
                    if ($signed(A) < 0) begin
                        Zero <= 1;
                    end
                end
                if (TwoBranch == 5'b00001) begin //BGEZ
                    if ($signed(A) >= 0) begin
                        Zero <= 1;
                    end
                end
            end
        end
        
        else if (BranchOp == 6'b011111) begin
            if (SEBits == 5'b10000) begin //SEB
                if (B[7] == 0) begin
                    ALUResult <= {24'b0,B[7:0]}; end
                else begin
                    ALUResult <= {24'b111111111111111111111111,B[7:0]}; end
            end
            else begin   // SEH
                if (B[15] == 0) begin
                    ALUResult <= {16'b0, B[15:0]};
                end
                else begin
                    ALUResult <= {16'b1111111111111111,B[15:0]};
                end
            end
        end 
         
        if(ALUControl == 4'b0000) begin // add
            ALUResult <= $signed(A)+$signed(B); end
            
        else if (ALUControl == 5'b10100) begin
            ALUResult <= ($signed(A) * $signed(B));
        end
        else if (ALUControl == 4'b0001) begin // sub
            ALUResult <= $signed(A)-$signed(B);
            if (($signed(A)-$signed(B)) == 0) begin
                Zero <= 1;
            end
        end
        else if (ALUControl == 4'b0010) begin //SLLV
            ALUResult <= B<<A;
             end
        else if (ALUControl == 4'b0011) begin // and
            ALUResult <= A & B; end
            
        else if (ALUControl == 4'b0100) begin // or
            ALUResult <= ($signed(A)|$signed(B)); end
            
        else if (ALUControl == 4'b0101) begin // less than
            ALUResult <= ($signed(A)<$signed(B)); end
            
        else if (ALUControl == 4'b0110) begin // equal 
            ALUResult <= (A==B); end //DOUBLE CHECK IF THIS IS THE DESIRED OUTPUT
            
        else if (ALUControl == 4'b0111) begin // not equal
            ALUResult <= ($signed(A)!=$signed(B)); end
            
        else if (ALUControl == 4'b1000) begin // shift left logical
            ALUResult <= (B<<A[10:6]); end
            
        else if (ALUControl == 4'b1001) begin // shift right logical

                ALUResult <= (B>>A[10:6]);
             end
           
            
        else if (ALUControl == 4'b1010) begin 
            ALUResult <= ((A >> B) | (A << (32-B))); end
            
        else if (ALUControl == 4'b1011) begin // xor
            ALUResult <= A^B; end
            
        else if (ALUControl == 4'b1110) begin
            ALUResult <= ~(A|B); end
        else if (ALUControl == 4'b1111) begin
            ALUResult <= B >> A;
        end
        else if (ALUControl == 5'b10000) begin //movn
        if (B != 0) begin
            ALUResult <= A;
        end 
        end
        else if (ALUControl == 5'b10001) begin
            if (B==0) begin
                ALUResult <=A;
            end
        end
        else if (ALUControl == 5'b10010) begin // shift right arithemtic
            ALUResult <= ($signed(B)>>>$signed(A[10:6])); end
        

        else if (ALUControl == 5'b10011) begin // shift right arithemtic variable
            ALUResult <= ($signed(B)>>>$signed(A)); end 
        end
        
        
        
            
 
endmodule


