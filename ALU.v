`timescale 1 ns / 1 ps
module ALU#( parameter N=16)(
input [N-1:0]A,
input [N-1:0]B,
input as,				// as is used to decide operation as = 0 subtract , as = 1 add
output reg [N-1:0]C			// Nbit output 
);
always@(A or B or as)			// Asynchronous 
begin
if ( as == 0 )
C <= B - A ;
else if ( as == 1)
C <= A + B ;
end
endmodule

