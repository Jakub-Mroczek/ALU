`timescale 1ns/1ns
`include "../circuits/multiplier.v"


module MultiplierTB
    #(parameter clk_period = 20,
    parameter n=8)
    (
        output reg clock=0,
        output reg reset=0,
        output reg start=0,
        output reg [n-1:0] A = 8'b00001101,
        output reg [n-1:0] B = 8'b00001001,
        input [n:0] product,
        input finished
    );
    Multiplier #(.n(n)) Mult(.clock(clock),.reset(reset),.start(start),.A(A),.B(B),.product(product),.finished(finished));
    
    initial begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, MultiplierTB);

        $monitor($time, " A=%b, B=%b, clock=%b, product=%b", A, B, clock, product);
        
        #100;
        #20 $display("Test Complete");
        #20 $finish;
    end

    always begin
        #(clk_period/2) clock=~clock;
    end

endmodule