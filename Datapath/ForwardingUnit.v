`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2020 03:43:27 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(EXrt, EXrs, WBrd, MEMrd, MEMRegWrite, WBRegWrite, MuxAControl, MuxBControl, WBMemRead); 
    
    input [4:0] EXrt, EXrs, WBrd, MEMrd;
    input MEMRegWrite, WBRegWrite, WBMemRead;
    
    output reg [1:0] MuxAControl, MuxBControl; 
    
    always @(*) begin
    
    MuxAControl <= 0;
    MuxBControl <= 0;
    
    if ((MEMRegWrite == 1) && (MEMrd != 0) && (MEMrd == EXrs)) begin
            MuxAControl <= 1; 
    end 
    else if ((WBRegWrite == 1) && (WBrd != 0) && (WBrd == EXrs)) begin
        MuxAControl <= 2;
    end
    else if ((WBMemRead == 1) && (WBrd != 0) && (WBrd == EXrs)) begin
        MuxAControl <= 2;
    end

    if ((MEMRegWrite == 1) && (MEMrd != 0) && (MEMrd == EXrt)) begin
        MuxBControl <= 1; 
    end
    else if ((WBRegWrite == 1) && (WBrd != 0) && (WBrd == EXrt)) begin
        MuxBControl <= 2;
    end
    else if ((WBMemRead == 1) && (WBrd != 0) && (WBrd == EXrt)) begin
        MuxBControl <= 2;
    end
    
    end
endmodule
