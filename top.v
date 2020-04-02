`timescale 1ns / 1ps
module Top(
input reset, 
input clk,
input[7:0] Divisor,
input[15:0] Dividend,
output reg [7:0] Remainder,Quotient,
output reg done,error
);
wire LoadDivisor,LoadDividend,muxselect,shiftval,shiftQuotientL,shiftAR,operationselect,errorflag,doneflag,clearQuotient;
wire [15:0] RegDivisorOut,ALUOut,muxout,RegDividendOut,Gout;
wire [7:0] RegQuotientOut;

Reg #(16) RegStoreDivisor
(.I({Divisor,8'b00000000}),.Q(RegDivisorOut),.clk(clk),.clear(1'b0),.shiftl(1'b0),.shiftr(shiftAR),.load(LoadDivisor),.shiftval(shiftval));

Reg #(16) RegStoreDividend		//This also stores Remainder
(.I(muxout),.Q(RegDividendOut),.clk(clk),.clear(1'b0),.shiftl(1'b0),.shiftr(1'b0),.load(LoadDividend),.shiftval(1'b0));

Reg #(8) RegStoreQuotient
(.I(8'b00000000),.Q(RegQuotientOut),.clk(clk),.clear(clearQuotient),.shiftl(shiftQuotientL),.shiftr(1'b0),.load(LoadDividend),.shiftval(shiftval));

ALU #(16) ALUfordivide
(.A(RegDividendOut),.B(RegDivisorOut),.as(operationselect),.C(ALUOut));

MUX #(16) mux
(.A(ALUOut),.B(Dividend),.select(muxselect),.C(muxout));

checker dividerchecker
(.Remainder(RegDividendOut),.RegDivisorOut(RegDivisorOut),.Quotient(RegQuotientOut),.doneflag(doneflag),.Gout(Gout),.errorflag(errorflag));

controller dividercon
(.R(RegDividendOut),.clk(clk),.reset(reset),.errorflag(errorflag),.LoadDivisor(LoadDivisor),.LoadDividend(LoadDividend),.muxsel(muxselect),.ShiftQuotientLeft(ShiftQuotientL),.ClearQuotient(clearQuotient),.shiftar(shiftAR),.shiftval(shiftval),.doneflag(doneflag),.as(operationselect));

always@(negedge clk)
begin
done <= doneflag;
error <= errorflag;
Remainder <= Gout[7:0];
Quotient <= Gout[15:8];
end
endmodule
