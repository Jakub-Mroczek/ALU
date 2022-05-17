module Mux2to1 
    #(parameter n = 4)
    ( 
    input [n-1:0] a,                  
    input [n-1:0] b,                               
    input sel,              
    output [n-1:0] out
    );             
  
   assign out = (sel ? a : b);  
  
endmodule  