`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 07:30:47 PM
// Design Name: 
// Module Name: HazardDetection
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HazardDetection(PCWrite, IFIDWrite, ControlWrite, IFIDrs, IFIDrt, IDEXrt,
    IDEXrd, EXMemRead, EXRegWrite, MEMRegDstMuxOut, MEMRegWrite, IDEXrs, 
    WBrd, WBRegWrite,EXMemWrite,MEMMemWrite,opcode, FlushSignal, PCsrc, Jump);
    
    output reg FlushSignal;
    input [1:0] Jump;
    input PCsrc;
    input [4:0] IFIDrs, IFIDrt, IDEXrt, IDEXrd, MEMRegDstMuxOut, IDEXrs, WBrd;
    input EXMemRead, EXRegWrite, MEMRegWrite, WBRegWrite,EXMemWrite,MEMMemWrite;
    input [5:0] opcode;

    output reg PCWrite, IFIDWrite, ControlWrite; 
    
    initial  begin 
    
    PCWrite <= 0;
    IFIDWrite <= 0;
    ControlWrite <= 0;
    
    end

    always @* begin 
    
    PCWrite <= 0;
    IFIDWrite <= 0;
    ControlWrite <= 0; 
    FlushSignal <= 0;
    
    if ((Jump == 1)|| (Jump == 2) || (PCsrc == 1)) begin
    
        FlushSignal <= 1;
        
    end

    if ((EXMemRead == 1)) begin //Checks if we are doing a LW
        if ((IDEXrt == IFIDrs) || (IDEXrt == IFIDrt)) begin //Checks if there are dependency       
            PCWrite <= 1;
            IFIDWrite <= 1;
            ControlWrite <= 1;
        end
    end
   
    end
    
endmodule
