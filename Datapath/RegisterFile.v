`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////
/*
module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData,
 RegWrite, Clk, ReadData1, ReadData2);


input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
input [31:0] WriteData;
input RegWrite, Clk;
output reg [31:0] ReadData1, ReadData2;

reg [31:0] RegFile [0:31];

initial begin
    RegFile[0] <= 32'h0; end

always @(posedge Clk) begin
    if(RegWrite == 1) begin
        RegFile[WriteRegister] <= WriteData;
        end
    end
always@ (negedge Clk) begin
     ReadData1 <= RegFile[ReadRegister1];
     ReadData2 <= RegFile[ReadRegister2];
     end  

endmodule  */
module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, 
RegWrite, Clk, ReadData1, ReadData2, v0, v1,debug_s0);

    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [4:0] WriteRegister;
    input wire [31:0] WriteData;
    input RegWrite;
    input Clk;
    
    output wire [31:0] v0, v1;
    output [31:0] ReadData1;
    output [31:0] ReadData2;
    output [31:0] debug_s0;

    //--// below is for post-synthesis simulation //--//

    (*mark_debug = "true"*) reg [31:0] RegFile [0:31];

    initial begin
    RegFile[0] <= 32'h0;
    RegFile[1] <= 32'h0;
    RegFile[2] <= 32'h0;
    RegFile[3] <= 32'h0;
    RegFile[4] <= 32'h0;
    RegFile[5] <= 32'h0;
    RegFile[6] <= 32'h0;
    RegFile[7] <= 32'h0;
    RegFile[8] <= 32'h0;
    RegFile[9] <= 32'h0;
    RegFile[10] <= 32'h0;
    RegFile[11] <= 32'h0;
    RegFile[12] <= 32'h0;
    RegFile[13] <= 32'h0;
    RegFile[14] <= 32'h0;
    RegFile[15] <= 32'h0;
    RegFile[16] <= 32'h0;
    RegFile[17] <= 32'h0;
    RegFile[18] <= 32'h0;
    RegFile[19] <= 32'h0;
    RegFile[20] <= 32'h0;
    RegFile[21] <= 32'h0;
    RegFile[22] <= 32'h0;
    RegFile[23] <= 32'h0;
    RegFile[24] <= 32'h0;
    RegFile[25] <= 32'h0;
    RegFile[26] <= 32'h0;
    RegFile[27] <= 32'h0;
    RegFile[28] <= 32'h0;
    RegFile[29] <= 9000;
    RegFile[30] <= 32'h0;
    RegFile[31] <= 32'h0;
    end



    always @(negedge Clk) begin
        if (RegWrite == 1) begin
           RegFile[WriteRegister] <= WriteData;
        end
    end
    
    assign ReadData1 = RegFile[ReadRegister1];
    assign ReadData2 = RegFile[ReadRegister2];
    assign v0 =  RegFile[2];
    assign v1 =  RegFile[3];
    assign debug_s0 = RegFile[16];
endmodule

