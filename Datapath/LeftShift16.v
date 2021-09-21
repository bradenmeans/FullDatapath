`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 06:24:43 PM
// Design Name: 
// Module Name: LeftShift16
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


module LeftShift16(in,out);
input [15:0] in;
output reg[31:0] out;

    always @(in)
    begin
        out <= in << 16;
    end
    
endmodule