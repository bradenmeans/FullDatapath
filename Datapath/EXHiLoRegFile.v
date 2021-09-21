`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2020 03:53:37 PM
// Design Name: 
// Module Name: EXHiLoRegFile
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


module EXHiLoRegFile(inA, inB, outA, outB);
input [31:0] inA,inB;
output reg [31:0] outA,outB;

always @(inA,inB) begin
    outA <= inA;
    outB <= inB;
end

endmodule
