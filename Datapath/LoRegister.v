`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2020 04:06:20 PM
// Design Name: 
// Module Name: LoRegister
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


module LoRegister(Product,Lo,enable, Clk);
input Clk;
input [63:0] Product;
input [3:0] enable;
output reg [31:0] Lo;
initial begin
    Lo <= 0;
 end

always @ (posedge Clk) begin
    if (enable == 1 || enable == 3) begin
         Lo <= Product[31:0];
    end
    else if (enable == 4) begin 
        Lo <= $signed(Lo) + Product[31:0];
    end
    else if (enable == 5) begin
        Lo <= $signed(Lo) - $signed(Product[31:0]);
    end
end
endmodule
