`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2020 04:03:49 PM
// Design Name: 
// Module Name: MEMHiLoRegFile
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


module MEMHiLoRegFile(inA,inB,Product,enable);
input [31:0] inA, inB;
input [3:0] enable;
output reg [63:0] Product;

always @(inA,inB,enable) begin 
    if (enable == 1 || enable == 2) begin
        Product <= inA;
    end
    else if (enable == 3 || enable == 4 || enable == 5) begin
        Product <= inA*inB;
    end 
  
end
endmodule
