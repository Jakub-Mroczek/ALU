`timescale 1ns/1ns
`include "../circuits/logic_right_shifter.v"


module RShifterTB
    #(parameter clk_period = 20,
    parameter n=4)
    (
        output reg clock=0,
        output reg en = 0,
        output reg [n-1:0] in,
        input [n-1:0] out_tb
    );
    RShifter #(.n(n)) RShift(.clock(clock),.en(en),.in(in),.out(out_tb));

    initial begin
        $dumpfile("logic_left_shifter_tb.vcd");
        $dumpvars(0, RShifterTB);

        $monitor($time, " in=%b, out_tb=%b, clock=%b, en=%b", in, out_tb, clock, en);
        in=4'b1010;
        en=1'b1;
        
        #100;
        #20 $display("Test Complete");
        #20 $finish;
    end

    always begin
        #(clk_period/2) clock=~clock;
        in <=out_tb;
    end

endmodule