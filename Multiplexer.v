`timescale 1ns / 1ps

/*/////////////////////
Multiplexer
//////////////////////*/

module MUX #(parameter term_size = 9) (

 input CLK,
 input [term_size-1:0] A, //first term
 input [term_size-1:0] B, //second term
 input Select,                 
 output reg [term_size-1:0] MUX_Out
);

always @(posedge CLK)
begin
      if (Select == 0) MUX_Out <= A;  //select input 0
      else if ( Select == 1) MUX_Out <= B;
  end
endmodule
