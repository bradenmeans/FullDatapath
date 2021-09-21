`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2020 05:38:15 PM
// Design Name: 
// Module Name: NewTopLevel
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


module NewTopLevel(Clk, Reset, out7, en_out);

    input Clk, Reset;
    wire ClkOut;
    output wire [6:0]out7; 
    output wire [7:0]en_out;
    //wire [31:0] PCResult, WriteData;
    wire [31:0] v0, v1;

    ClkDiv clock(Clk, Reset, ClkOut);   
    Two4DigitDisplay display(Clk, v0[15:0],v1[15:0], out7, en_out);
    TopLevel TL(ClkOut, Reset, v0, v1);

endmodule
