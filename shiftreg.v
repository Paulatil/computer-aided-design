`timescale 1ns / 1ps
module ShiftReg#(parameter N = 16)
(
input load,
input clear,			// synchronous clear
input shiftL,			// register shifts bits right if active
input shiftR,			// register shifts bits right if active
input shiftin,			// Value to be inserted during shift operation
input clk,
input [N-1:0]Din,			// N-bit parallel input lines	
output reg [N-1:0]Dout 		// N-bit parallel output lines
);
always@(posedge clk)//rising-edge triggered
begin
if( clear == 1)
Dout <= 0; 			// clear the register
else if (load == 1)
Dout <= Din; 			// load parallel inputs
else if (shiftR == 1)
Dout <= Dout >> 1 ; 	// shift right
else if (shiftL == 1)
Dout <= {Dout[N-2:0],shiftin}; 	// shift left
else
Dout <= Dout;				// default is hold
end
endmodule 
