`timescale 1ns / 1ps
/*///////////////////////////
	Top Module
///////////////////////////*/

module Top(
input CLK,
input Reset,
input [7:0] A,
input [15:0] B,
output [7:0] Q,
output [7:0] R,
output Done
);
wire [7:0] RegA, RegT, RegR, RegQ;
wire [8:0] RegC;
wire [15:0] RegB;
wire [2:0] AControl,BControl,CControl,TControl,RControl,QControl;
wire [8:0] MUX_Out;
wire [8:0] ALU_Out;
wire Select;
wire Q_shift_in;
wire Done_Internal;

assign Q = RegQ;
assign R = RegR;
assign Done = Done_Internal;

reg [7:0]temp;
always@*
begin
temp <= A; 
if ( temp == 0)
	$display("Divide by zero not defined");
end
	

Register#(8) A_Reg
(.CLK(CLK), .CLR(AControl[2]), .Load(AControl[1]),.Shift(AControl[0]), .Din(A),          .Shift_In(1'b0),       .Dout(RegA));
Register#(16) B_Reg
(.CLK(CLK), .CLR(BControl[2]), .Load(BControl[1]),.Shift(BControl[0]), .Din(B),          .Shift_In(1'b0),       .Dout(RegB));
Register#(9) C_Reg		// this helps detect overflow and holds the upper byte of Remainder/Dividend Register
(.CLK(CLK), .CLR(CControl[2]), .Load(CControl[1]),.Shift(CControl[0]), .Din(MUX_Out),    .Shift_In(RegB[15]),   .Dout(RegC));
Register#(8) T_Reg		// Temporary Reigster that helps restore the value
(.CLK(CLK), .CLR(TControl[2]), .Load(TControl[1]),.Shift(TControl[0]), .Din(RegC[7:0]),  .Shift_In(1'b0),       .Dout(RegT));
Register#(8) R_Reg
(.CLK(CLK), .CLR(RControl[2]), .Load(RControl[1]),.Shift(RControl[0]), .Din(RegC[7:0]),  .Shift_In(1'b0),       .Dout(RegR));
Register#(8) Q_Reg
(.CLK(CLK), .CLR(QControl[2]), .Load(QControl[1]),.Shift(QControl[0]), .Din(8'b00000000),.Shift_In(Q_shift_in), .Dout(RegQ));
ControllerUnit ControlU
(.CLK(CLK),.Reset(Reset),.MSB_C(RegC[8]),.Done(Done_Internal),.Q_shift_in(Q_shift_in),.Select(Select),.AControl(AControl),.BControl(BControl), 
.CControl(CControl),.TControl(TControl),.RControl(RControl),.QControl(QControl));
ALU#(9) ALU1 (.X(RegC),.Y({1'b0,RegA}),.ALU_Out(ALU_Out));
MUX #(9) Multiplexer (.CLK(CLK),.A({1'b0,RegT}),.B(ALU_Out),.Select(Select),.MUX_Out(MUX_Out));



endmodule
