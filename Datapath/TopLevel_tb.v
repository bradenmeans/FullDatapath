//Name: Braden Means, Brendan Yip, Emmanuel Enriquez
//Percent Effort: 33.3, 33.3, 33.3


`timescale 1ns / 1ps

module TopLevel_tb();
    reg Reset, Clk;
    wire [31:0] v0,v1;

    TopLevel u0 (
    .Clk (Clk),
    .Reset (Reset),
    .v0 (v0),
    .v1(v1)
    );
    
    always begin
        Clk <= 0;
    //#100;
    forever #50 Clk <= ~Clk;

 
end
initial begin
    Reset <= 0;
    
    #200 Reset <= 0;
    #200;



    end

endmodule
    
    
