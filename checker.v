`timescale 1ns / 1ps
module checker (
input [15:0] Remainder, RegDivisorOut,
input [7:0] Quotient,
input doneflag,
output reg [15:0] Gout,		//Remainder occupies lower byte while Quotient occupies upper byte
output reg errorflag
);
initial 
begin
assign errorflag = 0 ; 		// At begining , no error present
assign Gout = 0;
end

always@(Remainder or RegDivisorOut or Quotient or doneflag)
begin
if(doneflag == 0)		// if Divison operation is in progress
begin
if(RegDivisorOut == 0)		// Division by zero , flag 
errorflag = 1 ;			// Activate Error Flag
end
if ( doneflag == 1 )
begin
if( Quotient == 255 && Remainder > 0 )		//Quotient is greater than 8 bits
errorflag = 1;
else			// if all conditions don't match , valid result
begin
Gout[7:0] <= Remainder[7:0];		// Remainder is lower byte
Gout[15:8] <= Quotient;			// Quotient is upper byte
end
end
end
endmodule

