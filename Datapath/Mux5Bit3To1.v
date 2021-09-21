`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 09:28:30 PM
// Design Name: 
// Module Name: Mux5Bit3To1
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


module Mux5Bit3To1(out,inA,inB,inC,sel);
    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input [4:0] inC;
    input [1:0] sel;
    
    always @(sel, inA, inB, inC) begin
        if (sel == 0) 
            out <= inA;
        else if (sel == 1)begin
            out <= inB;
        end
        else if (sel == 2) begin
            out <= inC;
        end
    end
endmodule
