`timescale 1ns / 100ps
////////////////////
//the register module
////////////////////

module Register#(parameter n = 16 )
(
input clk,
input reset,
input Load,
input Shift,
input [n-1:0] Din,
input Shift_In,
output reg [n-1:0] Dout
);
always@(posedge clk)
	begin
			if(reset==1)
				Dout <= 0;
			else if (Load==1)
				Dout <= Din;
			else if(Shift==1)
				Dout <= {Dout[n-2:0],Shift_In};
			else
				Dout <= Dout;
	end
endmodule
	