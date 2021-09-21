`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2020 04:14:07 PM
// Design Name: 
// Module Name: JumpAddress
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


module JumpAddress(PCPlus4Address,Instruction,JumpAddress);
    
    input [31:0] PCPlus4Address;
    input [31:0] Instruction;
    output reg [31:0] JumpAddress;

    initial begin
        JumpAddress <= 0;
    end

    always @(*) begin
        JumpAddress <= {PCPlus4Address[31:28],Instruction[25:0],2'b00};
    end



endmodule
