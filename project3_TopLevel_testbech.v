`timescale 1ns / 100ps
////////////////////////
// the testbench module to instantiate the top level
//////////////////////


module TopLevel_testbench();

reg clk;
reg clear;
reg [7:0] A;
reg [15:0] B;
wire [7:0] Q;
wire [7:0] R;
wire Done;

 TopLevel UUT (.clk(clk), .clear(clear), .A(A), .B(B), .Q(Q), .R(R), .Done(Done));
always #10 clk<=~clk;
initial
begin
$display("Test at time = ", $time);
clk<=0;
clear<=1;
A<=8'b00000011;  //divide by 3
B<=16'b0000000000001010; //dividend is 10
#25
clear<=0;
#500;
if(Q!==8'b00000011)  // the  Quotient check
$display("ERROR: Q should be 11101110 but Q = %b",Q);
if(R!=8'b00000001)  // the remainder check
$display("ERROR: R should be 01101100 but R = %b", R);
$display(" ");
clear<=1;
A<=8'b00000000;   //divide by zero
B<=16'b000000000001011;
#25;
clear<=0;
#5000;
if(Q!==8'b00000000)
	$display("ERROR : Q should be 11001000 but Q=%b", Q);
if(R !== 8'b00001011)
$display("ERROR : R should be 00000000 but R = %b", R);

$display("Test end at time = ", $time);
end
endmodule