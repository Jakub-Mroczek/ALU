`include "../circuits/full_adder.v"

module Adder
    #(parameter n=4)
    (
    input [n-1:0] augend,
    input [n-1:0] addend,
    output [n:0] final_sum
    );

    wire [n:0] carries;
    wire [n-1:0] sums;

    assign carries[0] = 1'b0;

    genvar i;
    generate
        for(i=0; i <n; i=i+1) begin
            FullAdder full_adder_gen(.a(augend[i]),.b(addend[i]),.cin(carries[i]),.cout(carries[i+1]),.sum(sums[i]));
        end
    endgenerate

    assign final_sum[n-1:0] = sums;
    assign final_sum[n] = carries[n];

endmodule
