`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 06:45:09 PM
// Design Name: 
// Module Name: Mux32Bit4To1
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


module Mux32Bit4To1(out, inA, inB, inC, inD, inE, sel);
input [31:0] inA, inB, inC, inD, inE;
input [2:0] sel;
output reg [31:0] out;

always @(inA, inB, inC, inD, inE, sel) begin
    if(sel == 2'b00) begin
        out <= inA;
        end
    else if(sel == 2'b01) begin
        out <= inB;
        end
    else if(sel == 2'b10) begin
        out <= inC;
        end
    else if(sel == 2'b11) begin
        out <= inD;
        end
    else if (sel == 3'b100) begin
        out <= inE;
        end

end
endmodule
