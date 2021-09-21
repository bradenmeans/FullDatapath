`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - SignExtension.v
// Description - Sign extension module.  
// If the most significant bit of in (in[15]) = 0, 
//create the 32-bit "out" output by making out[15:0] equal to "in" and make other bits (bits 16 to 31) to 0
// If the most significant bit of in (in[15]) = 1, 
//create the 32-bit "out" output by making out[15:0] equal to "in" and make other bits to 1
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out,OriSignal);

    input [15:0] in;
    input OriSignal;
    integer i;

    output reg [31:0] out;   //using always @
    //output [31:0] out;   //using assign statement


    always @(in,OriSignal) begin

    //out <= {16'h0,in};
    if (OriSignal == 0) begin
        if((in[15]) == 0) begin
             out <= {16'h0,in};
        end

         else if((in[15])==1) begin
          out <= {16'hFFFF,in};
         end
     end
     else if (OriSignal == 1) begin
        out <= {16'h0,in};
     end
     end



endmodule