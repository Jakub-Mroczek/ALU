module LShifter
    #(parameter n=4)
    (
    input wire clock,
    input wire en,
    input wire [n-1:0] in,
    output wire [n-1:0] out
    );

    generate
        assign out[0] = 1'b0;
        for(genvar i=0; i<n-1; i=i+1) begin
            assign out[i+1] = in[i];
        end
    endgenerate
    
endmodule