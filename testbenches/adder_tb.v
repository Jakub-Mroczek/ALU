`timescale 1ns/1ns
`include "../circuits/adder.v"

module AdderTB
    #(parameter n = 4)
    (
    output reg [n-1:0] augend,
    output reg [n-1:0] addend,
    input [n:0] final_sum
    );
    integer i;
    integer j;
    Adder #(.n(n)) dutAdder(.augend(augend),.addend(addend),.final_sum(final_sum));

    initial begin
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, AdderTB);

        augend = 4'b0;
        addend = 4'b0;

        $monitor($time, " augend=%b, addend=%b, final_sum=%b", augend, addend, final_sum);
        for(i=0; i <2**n; i=i+1) begin
            #10;
            for(j=0; j <2**n; j=j+1) begin
                #10;     
                addend = addend + 1'b1;   
            end
            augend = augend + 1'b1;
        end

        #10 $display("Test Complete!");
        #10 $finish;     
    end
endmodule