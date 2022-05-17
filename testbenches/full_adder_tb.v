`timescale 1ns/1ns
`include "../circuits/full_adder.v"


module FullAdderTB(
    output reg a,
    output reg b,
    output reg cin,
    input cout,
    input sum
);
    FullAdder dut1(.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
    // FullAdder dut1(a,b,cin,cout,sum);

    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, FullAdderTB);

        a=0;
        b=0;
        cin=0;
        $monitor($time, "a=%b", "b=%b", "cin=%b", "cout=%b", "sum=%b", a, b, cin, cout, sum);
        #10 cin=0; b=0; a=1;
        #10 cin=0; b=1; a=0;
        #10 cin=0; b=1; a=1;
        #10 cin=1; b=0; a=0;
        #10 cin=1; b=0; a=1;
        #10 cin=1; b=1; a=0;
        #10 cin=1; b=1; a=1;
        #10 $display("Test Complete");
        #10 $finish;
    end
endmodule