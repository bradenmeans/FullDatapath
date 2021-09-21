`timescale 1ns / 1ps
module AndGate(Branch ,ALUzero, PCsrc);

    input Branch, ALUzero;
    output reg PCsrc;

    always @(Branch,ALUzero) begin 

    PCsrc <= Branch & ALUzero;

    end
endmodule