`timescale 1ns / 1ps
/*///////////////////////
	TestBench
///////////////////////*/


module TestBench();

reg CLK;
reg Reset;
reg [7:0] A;
reg [15:0] B;
wire [7:0] Q;
wire [7:0] R;
wire Done;


Top UUT (.CLK(CLK),.Reset(Reset),.A(A),.B(B),.Q(Q),.R(R),.Done(Done));
always #10 CLK<=~CLK;
initial
	begin
		$display("Test at time = ", $time);
		CLK <= 0;
		Reset <= 1;
		A <= 8'b11111100;	// 252
		B <= 16'b1010110011110100; // 44276
		#25
		Reset <= 0;
		#5000;
		if( Q!==8'b10101111 )	//176
		$display("ERROR: Q should be 10101111 but Q = %b",Q);
		if( R!==8'b10110000 )
		$display("ERROR: R should be 10110000 but R = %b", R);		//176
		$display(" ");
		Reset <= 1;
		A <= 8'b11001010;	//202
		B <= 16'b1001110001000100;	
		#25;
		Reset <= 0;
		#5000;
		if( Q!==8'b11000110 )	//198
			$display("ERROR : Q should be 11000110 but Q=%b", Q);
		if( R!== 8'b1000 )	//8
			$display("ERROR : R should be 1000 but R = %b", R);

		$display("Test end at time = ", $time);
	end
endmodule
