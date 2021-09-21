`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
       //Create 2D array for memory with 128 32-bit elements here
        reg [31:0] memory [0:226];
        
        integer i;
        
        
        initial begin
        /*
memory[0] <= 32'b00100011101111011111111111111100;	//	main:			addi	$sp, $sp, -4
memory[1] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[2] <= 32'b00110100000001000000000001100000;	//				ori	$a0, $zero, 96
memory[3] <= 32'b00110100000001010000000001110000;	//				ori	$a1, $zero, 112
memory[4] <= 32'b00110100000001100011000101001100;	//				ori	$a2, $zero, 12620
memory[5] <= 32'b00001100000000000000000000010110;	//				jal	vbsme
memory[6] <= 32'b00000000000000000000000000000000;	//				nop
memory[7] <= 32'b00110100000001000011010101001100;	//				ori	$a0, $zero, 13644
memory[8] <= 32'b00110100000001010011010101011100;	//				ori	$a1, $zero, 13660
memory[9] <= 32'b00110100000001100110011000111000;	//				ori	$a2, $zero, 26168
memory[10] <= 32'b00001100000000000000000000010110;	//				jal	vbsme
memory[11] <= 32'b00000000000000000000000000000000;	//				nop
memory[12] <= 32'b00110100000001000110101000111000;	//				ori	$a0, $zero, 27192
memory[13] <= 32'b00110100000001010110101001001000;	//				ori	$a1, $zero, 27208
memory[14] <= 32'b00110100000001101001101100100100;	//				ori	$a2, $zero, 39716
memory[15] <= 32'b00001100000000000000000000010110;	//				jal	vbsme
memory[16] <= 32'b00000000000000000000000000000000;	//				nop
memory[17] <= 32'b00110100000001001001111100100100;	//				ori	$a0, $zero, 40740
memory[18] <= 32'b00110100000001011001111100110100;	//				ori	$a1, $zero, 40756
memory[19] <= 32'b00110100000001101101000000010000;	//				ori	$a2, $zero, 53264
memory[20] <= 32'b00001100000000000000000000010110;	//				jal	vbsme
memory[21] <= 32'b00000000000000000000000000000000;	//				nop
memory[22] <= 32'b00000000000000000001000000100000;	//	vbsme:			add	$v0, $0, $0
memory[23] <= 32'b00000000000000000001100000100000;	//				add	$v1, $0, $0
memory[24] <= 32'b00100000000100000111010100110000;	//				addi	$s0, $0, 30000
memory[25] <= 32'b00000000000000001000100000100000;	//				add	$s1, $0, $0
memory[26] <= 32'b10001100100100100000000000000000;	//				lw	$s2, 0($a0)
memory[27] <= 32'b10001100100100110000000000000100;	//				lw	$s3, 4($a0)
memory[28] <= 32'b10001100100101000000000000001000;	//				lw	$s4, 8($a0)
memory[29] <= 32'b10001100100101010000000000001100;	//				lw	$s5, 12($a0)
memory[30] <= 32'b00000010010101001001000000100010;	//				sub	$s2, $s2, $s4
memory[31] <= 32'b00100010010100100000000000000001;	//				addi	$s2, $s2, 1
memory[32] <= 32'b00000010011101011001100000100010;	//				sub	$s3, $s3, $s5
memory[33] <= 32'b00100010011100110000000000000001;	//				addi	$s3, $s3, 1
memory[34] <= 32'b00000000000000000100000000100000;	//				add	$t0, $0, $0
memory[35] <= 32'b00000000000000000100100000100000;	//				add	$t1, $0, $0
memory[36] <= 32'b00000001000100100101100000101010;	//	spiral:			slt	$t3, $t0, $s2
memory[37] <= 32'b00010001011000000000000001000011;	//				beq	$t3, $0, exitSpiral
memory[38] <= 32'b00000001001100110101100000101010;	//				slt	$t3, $t1, $s3
memory[39] <= 32'b00010001011000000000000001000001;	//				beq	$t3, $0, exitSpiral
memory[40] <= 32'b00000001001000000110000000100000;	//	rightColStart:		add	$t4, $t1, $0
memory[41] <= 32'b00000001100100110101100000101010;	//	moveRightCol:		slt	$t3, $t4, $s3
memory[42] <= 32'b00010001011000000000000000001001;	//				beq	$t3, $0, rightColExit
memory[43] <= 32'b00000001000000001100000000100000;	//				add	$t8, $t0, $0
memory[44] <= 32'b00000001100000001100100000100000;	//				add	$t9, $t4, $0
memory[45] <= 32'b00100011101111011111111111111100;	//				addi	$sp, $sp, -4
memory[46] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[47] <= 32'b00001100000000000000000001101010;	//				jal	minSADBegin
memory[48] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[49] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[50] <= 32'b00100001100011000000000000000001;	//				addi	$t4, $t4, 1
memory[51] <= 32'b00001000000000000000000000101001;	//				j	moveRightCol
memory[52] <= 32'b00100001000010000000000000000001;	//	rightColExit:		addi	$t0, $t0, 1
memory[53] <= 32'b00000001000100100101100000101010;	//	downRowStart:		slt	$t3, $t0, $s2
memory[54] <= 32'b00010001011000000000000000011111;	//				beq	$t3, $0, rowUpStart
memory[55] <= 32'b00000001000000000110000000100000;	//				add	$t4, $t0, $0
memory[56] <= 32'b00000001100100100101100000101010;	//	downRow:		slt	$t3, $t4, $s2
memory[57] <= 32'b00010001011000000000000000001001;	//				beq	$t3, $0, downRowExit
memory[58] <= 32'b00000001100000001100000000100000;	//				add	$t8, $t4, $0
memory[59] <= 32'b00100010011110011111111111111111;	//				addi	$t9, $s3, -1
memory[60] <= 32'b00100011101111011111111111111100;	//				addi	$sp, $sp, -4
memory[61] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[62] <= 32'b00001100000000000000000001101010;	//				jal	minSADBegin
memory[63] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[64] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[65] <= 32'b00100001100011000000000000000001;	//				addi	$t4, $t4, 1
memory[66] <= 32'b00001000000000000000000000111000;	//				j	downRow
memory[67] <= 32'b00100010011100111111111111111111;	//	downRowExit:		addi	$s3, $s3, -1
memory[68] <= 32'b00000001000100100101100000101010;	//	leftColStart:		slt	$t3, $t0, $s2
memory[69] <= 32'b00010001011000000000000000010000;	//				beq	$t3, $0, rowUpStart
memory[70] <= 32'b00000010011000000110000000100000;	//				add	$t4, $s3, $0
memory[71] <= 32'b00100001100011001111111111111111;	//				addi	$t4, $t4, -1
memory[72] <= 32'b00100001001010011111111111111111;	//				addi	$t1, $t1, -1
memory[73] <= 32'b00000001001011000101100000101010;	//	moveLeftCol:		slt	$t3, $t1, $t4
memory[74] <= 32'b00010001011000000000000000001001;	//				beq	$t3, $0, leftColExit
memory[75] <= 32'b00100010010110001111111111111111;	//				addi	$t8, $s2, -1
memory[76] <= 32'b00000001100000001100100000100000;	//				add	$t9, $t4, $0
memory[77] <= 32'b00100011101111011111111111111100;	//				addi	$sp, $sp, -4
memory[78] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[79] <= 32'b00001100000000000000000001101010;	//				jal	minSADBegin
memory[80] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[81] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[82] <= 32'b00100001100011001111111111111111;	//				addi	$t4, $t4, -1
memory[83] <= 32'b00001000000000000000000001001001;	//				j	moveLeftCol
memory[84] <= 32'b00100001001010010000000000000001;	//	leftColExit:		addi	$t1, $t1, 1
memory[85] <= 32'b00100010010100101111111111111111;	//				addi	$s2, $s2, -1
memory[86] <= 32'b00000001001100110101100000101010;	//	rowUpStart:		slt	$t3, $t1, $s3
memory[87] <= 32'b00010001011000001111111111001100;	//				beq	$t3, $0, spiral
memory[88] <= 32'b00000010010000000110000000100000;	//				add	$t4, $s2, $0
memory[89] <= 32'b00100001100011001111111111111111;	//				addi	$t4, $t4, -1
memory[90] <= 32'b00100001000010001111111111111111;	//				addi	$t0, $t0, -1
memory[91] <= 32'b00000001000011000101100000101010;	//	rowUp:			slt	$t3, $t0, $t4
memory[92] <= 32'b00010001011000000000000000001001;	//				beq	$t3, $0, rowUpExit
memory[93] <= 32'b00000001100000001100000000100000;	//				add	$t8, $t4, $0
memory[94] <= 32'b00000001001000001100100000100000;	//				add	$t9, $t1, $0
memory[95] <= 32'b00100011101111011111111111111100;	//				addi	$sp, $sp, -4
memory[96] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[97] <= 32'b00001100000000000000000001101010;	//				jal	minSADBegin
memory[98] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[99] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[100] <= 32'b00100001100011001111111111111111;	//				addi	$t4, $t4, -1
memory[101] <= 32'b00001000000000000000000001011011;	//				j	rowUp
memory[102] <= 32'b00100001000010000000000000000001;	//	rowUpExit:		addi	$t0, $t0, 1
memory[103] <= 32'b00100001001010010000000000000001;	//				addi	$t1, $t1, 1
memory[104] <= 32'b00001000000000000000000000100100;	//				j	spiral
memory[105] <= 32'b00000011111000000000000000001000;	//	exitSpiral:		jr	$ra
memory[106] <= 32'b00000000000000000111000000100000;	//	minSADBegin:		add	$t6, $0, $0
memory[107] <= 32'b00000000000000000111100000100000;	//				add	$t7, $0, $0
memory[108] <= 32'b00000000000000001000100000100000;	//				add	$s1, $0, $0
memory[109] <= 32'b00100011101111011111111111111100;	//	iterRowSAD:		addi	$sp, $sp, -4
memory[110] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[111] <= 32'b00001100000000000000000001111110;	//				jal	iterColSAD
memory[112] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[113] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[114] <= 32'b00000011001101011100100000100010;	//				sub	$t9, $t9, $s5
memory[115] <= 32'b00100000000011110000000000000000;	//				addi	$t7, $0, 0
memory[116] <= 32'b00100011000110000000000000000001;	//				addi	$t8, $t8, 1
memory[117] <= 32'b00100001110011100000000000000001;	//				addi	$t6, $t6, 1
memory[118] <= 32'b00010101110101001111111111110110;	//				bne	$t6, $s4, iterRowSAD
memory[119] <= 32'b00000010001100000101100000101010;	//				slt	$t3, $s1, $s0
memory[120] <= 32'b00010001011000000000000000100100;	//				beq	$t3, $0, exitCalcSAD
memory[121] <= 32'b00000011000000000001000000100000;	//				add	$v0, $t8, $0
memory[122] <= 32'b00000000010101000001000000100010;	//				sub	$v0, $v0, $s4
memory[123] <= 32'b00000011001000000001100000100000;	//				add	$v1, $t9, $0
memory[124] <= 32'b00000010001000001000000000100000;	//				add	$s0, $s1, $0
memory[125] <= 32'b00001000000000000000000010011101;	//				j	exitCalcSAD
memory[126] <= 32'b00100011101111011111111111111100;	//	iterColSAD:		addi	$sp, $sp, -4
memory[127] <= 32'b10101111101111110000000000000000;	//				sw	$ra, 0($sp)
memory[128] <= 32'b00001100000000000000000010000111;	//				jal	differenceCalc
memory[129] <= 32'b10001111101111110000000000000000;	//				lw	$ra, 0($sp)
memory[130] <= 32'b00100011101111010000000000000100;	//				addi	$sp, $sp, 4
memory[131] <= 32'b00100001111011110000000000000001;	//				addi	$t7, $t7, 1
memory[132] <= 32'b00100011001110010000000000000001;	//				addi	$t9, $t9, 1
memory[133] <= 32'b00010101111101011111111111111000;	//				bne	$t7, $s5, iterColSAD
memory[134] <= 32'b00000011111000000000000000001000;	//				jr	$ra
memory[135] <= 32'b10001100100011010000000000000100;	//	differenceCalc:		lw	$t5, 4($a0)
memory[136] <= 32'b00000000000000000000000000000000;	//				nop
memory[137] <= 32'b01110001101110000110100000000010;	//				mul	$t5, $t5, $t8
memory[138] <= 32'b00000001101110010110100000100000;	//				add	$t5, $t5, $t9
memory[139] <= 32'b00000000000011010110100010000000;	//				sll	$t5, $t5, 2
memory[140] <= 32'b00000001101001010110100000100000;	//				add	$t5, $t5, $a1
memory[141] <= 32'b10001101101011010000000000000000;	//				lw	$t5, 0($t5)
memory[142] <= 32'b01110001110101010101000000000010;	//				mul	$t2, $t6, $s5
memory[143] <= 32'b00000001010011110101000000100000;	//				add	$t2, $t2, $t7
memory[144] <= 32'b00000000000010100101000010000000;	//				sll	$t2, $t2, 2
memory[145] <= 32'b00000001010001100101000000100000;	//				add	$t2, $t2, $a2
memory[146] <= 32'b10001101010010100000000000000000;	//				lw	$t2, 0($t2)
memory[147] <= 32'b00010101101010100000000000000001;	//				bne	$t5, $t2, calcSAD
memory[148] <= 32'b00000011111000000000000000001000;	//				jr	$ra
memory[149] <= 32'b00000001101010101011000000100010;	//	calcSAD:		sub	$s6, $t5, $t2
memory[150] <= 32'b00000010110000000101100000101010;	//				slt	$t3, $s6, $0
memory[151] <= 32'b00010101011000000000000000000010;	//				bne	$t3, $0, calcSADNegative
memory[152] <= 32'b00000010001101101000100000100000;	//				add	$s1, $s1, $s6
memory[153] <= 32'b00000011111000000000000000001000;	//				jr	$ra
memory[154] <= 32'b00000001010011011011000000100010;	//	calcSADNegative:	sub	$s6, $t2, $t5
memory[155] <= 32'b00000010001101101000100000100000;	//				add	$s1, $s1, $s6
memory[156] <= 32'b00000011111000000000000000001000;	//				jr	$ra
memory[157] <= 32'b00000011111000000000000000001000;	//	exitCalcSAD:		jr	$ra
*/
$readmemh("C:/Users/brade/OneDrive/Desktop/Project_Fall2020/Instruction_memory.txt",
memory);
        end
        
        always @ (*) begin
            Instruction <= memory[Address[11:2]];    
        end

endmodule
