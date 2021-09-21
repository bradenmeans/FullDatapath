`timescale 1ns / 1ps

module Or(A,B,Out);
input A,B;
output reg Out;

always @(A,B) begin
Out <= A | B;
end

endmodule
