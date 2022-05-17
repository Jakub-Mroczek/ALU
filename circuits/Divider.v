`include "../circuits/adder.v"
`include "../circuits/logic_right_shifter.v"
`include "../circuits/logic_left_shifter.v"
`include "../circuits/2to1_mux.v"

module Divider
    //Multiplier algo as placeholder 
    #(parameter n = 8)
    (
    input wire clock,
    input reset,
    input start,
    input [n-1:0] A,
    input [n-1:0] B,
    output wire [n:0] product,
    output finished
    );

    reg en_RS = 1'b1;
    reg en_LS = 1'b1;
    
    //Input A
    wire [n-1:0] OutMuxA;
    wire SelectMuxA = 0;
    wire [n-1:0] OutLShift;
    reg [n-1:0] InLShift = 8'b00001101;
    Mux2to1 #(.n(n)) multMuxA(.a(A),.b(OutLShift),.sel(SelectMuxA),.out(OutMuxA));
    LShifter #(.n(n)) multLShift(.clock(clock),.en(en_LS),.in(InLShift),.out(OutLShift));

    //Input B
    wire [n-1:0] OutMuxB;
    wire SelectMuxB = 0;
    wire [n-1:0] OutRShift;
    reg [n-1:0] InRShift = 8'b00001011;
    Mux2to1 #(.n(n)) multMuxB(.a(A),.b(OutRShift),.sel(SelectMuxB),.out(OutMuxB));
    RShifter #(.n(n)) multRShift(.clock(clock),.en(en_RS),.in(InRShift),.out(OutRShift));

    always @(posedge clock) begin
        InLShift <= OutMuxA;
        InRShift <= OutMuxB;
        FeedbackAdder <= OutMuxProduct;
    end

    //Adder
    wire [n-1:0] OutMuxProduct;
    wire SelectMuxProduct = 1;
    wire [n-1:0] InAdder;
    reg [n-1:0] FeedbackAdder = 0;
    assign InAdder[n-1:0] = InLShift[n-1:0] & {(n){InRShift[0]}};
    Adder #(.n(n)) multAdder(.augend(InAdder),.addend(FeedbackAdder),.final_sum(product));
    Mux2to1 #(.n(n)) multMuxProduct(.a(product[n-1:0]),.b(8'b0),.sel(SelectMuxProduct),.out(OutMuxProduct));

endmodule
