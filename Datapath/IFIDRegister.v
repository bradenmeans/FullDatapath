`timescale 1ns / 1ps

module IFIDRegister(Clk, inputPCValue, outputPCValue, inputInstructionMem, 
    outputInstructionMem, IFIDWrite, FlushSignal);

    input Clk,IFIDWrite,FlushSignal;

    input [31:0] inputPCValue;
    output [31:0] outputPCValue;

    input [31:0] inputInstructionMem;
    output [31:0] outputInstructionMem;
    reg [31:0] Register [1:0];

     initial begin 
        Register[0] <= 0;
        Register[1] <= 0;
     end 


    always @(posedge Clk) begin

    if(IFIDWrite == 0) begin
        Register[0] <= inputPCValue;
        Register[1] <= inputInstructionMem;
    end
    else if (IFIDWrite == 1) begin
        Register[0] <= Register[0];
        Register[1] <= Register[1];
    end

    if (FlushSignal == 1) begin
        Register[0] <= 0;
        Register[1] <= 0;

    end
    /*
    else begin
        Register[0] <= Register[0];
        Register[1] <= Register[1];
    end */
    end
         assign outputPCValue = Register[0];
         assign outputInstructionMem = Register[1]; 

endmodule