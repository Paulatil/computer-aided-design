`timescale 1ns / 100ps
/////////////////////
// the top level module
//////////////////////

module TopLevel(clk, clear, A, B, Q, R, Done);
input clk;
input clear;
input [7:0] A;
input [15:0] B;
output [7:0] Q, R;
output Done;
wire [7:0] RegA, RegR, RegQ;
wire [16:0] RegM;
wire [15:0] RegB, RegN;
wire [2:0] A_sig, B_sig, M_sig, N_sig, R_sig, Q_sig;
wire [16:0] M_Out;
wire [8:0] A_Out;
wire Sel;
wire Q_shift_in;
wire Done_Int;

assign Q=RegQ;
assign R=RegR;
assign Done = Done_Int;

Register#(8) A_Reg  // the divisor reg: load
(.clk(clk), .reset(A_sig[2]), .Load(A_sig[1]),.Shift(A_sig[0]), .Din(A), .Shift_In(1'b0), .Dout(RegA));
Register#(16) B_Reg // the dividend reg: load  
(.clk(clk), .reset(B_sig[2]), .Load(B_sig[1]),.Shift(B_sig[0]), .Din(B), .Shift_In(1'b0), .Dout(RegB));
Register#(9) M_Reg // the accumulator: load and clear
(.clk(clk), .reset(M_sig[2]), .Load(M_sig[1]),.Shift(M_sig[0]), .Din(M_Out), .Shift_In(RegB[15]), .Dout(RegM));
Register#(8) N_Reg // temp reg: clear and load
(.clk(clk), .reset(N_sig[2]), .Load(N_sig[1]),.Shift(N_sig[0]), .Din(RegM[15:0]), .Shift_In(1'b0), .Dout(RegN));
 Register#(8) R_Reg  // the remainder reg: clear and load
(.clk(clk), .reset(R_sig[2]), .Load(R_sig[1]),.Shift(R_sig[0]), .Din(RegM[7:0]), .Shift_In(1'b0), .Dout(RegR));
Register#(8) Q_Reg // the quotient reg: shifts, loads, clears
(.clk(clk), .reset(Q_sig[2]), .Load(Q_sig[1]),.Shift(Q_sig[0]), .Din(8'b00000000), .Shift_In(Q_shift_in), .Dout(RegQ));
controller_unit controller
(.clk(clk), .clear(clear), .LB_M(RegM[8]), .Done(Done_Int), .Q_shift_in(Q_shift_in), .Sel(Sel), .A_sig(A_sig), .B_sig(B_sig), 
 .M_sig(M_sig), .N_sig(N_sig), .R_sig(R_sig), .Q_sig(Q_sig));
ALU#(9) Subtractor
	(.D1(Regb),.D0({8'b0000000,RegA}),.A_Out(A_Out));
Mux #(9) Multiplexer
(.clk(clk),.I0({1'b0,RegN}),.I1(A_Out),.Sel(Sel),.M_Out(M_Out));

endmodule

