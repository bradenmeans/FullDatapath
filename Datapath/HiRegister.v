`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2020 04:05:58 PM
// Design Name: 
// Module Name: HiRegister
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


module HiRegister(Product,Hi,enable, Clk);
input Clk;
input [63:0] Product;
input [3:0] enable;
output reg [31:0] Hi;

initial begin
    Hi <= 0;
 end

always @ (posedge Clk) begin
    if (enable == 3) begin
         Hi <= Product[63:32];
    end
    else if (enable == 2) begin
        Hi <= Product[31:0];
    end
    else if (enable == 4) begin 
        Hi <= $signed(Hi) + Product[63:32];
    end
    else if (enable == 5) begin
        Hi <= $signed(Hi) - Product[63:32];
    end
end
endmodule
