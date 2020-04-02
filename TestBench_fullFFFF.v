`timescale 1ns / 1ps
/*///////////////////////
	TestBench
///////////////////////*/


module TestBench_FullRangeFFFF();

reg CLK;
reg Reset;
reg [7:0] A;
reg [15:0] B;
wire [7:0] Q;
wire [7:0] R;
wire Done;
integer j;
reg [7:0]tempQ,tempR;
Top UUT (.CLK(CLK),.Reset(Reset),.A(A),.B(B),.Q(Q),.R(R),.Done(Done));
always #10 CLK<=~CLK;
reg [15:0]x;
initial
	begin
		$display("Test at time = ", $time);
		CLK <= 0;
		for ( j=16'hffff;j>=0;j=j-1)
		begin
			Reset <= 1 ;
			x <= j;
			A <= 8'hff ;
			B <= x ;
			#25
			Reset <= 0;
			#5000;
			tempQ = B/A;
			tempR = R%A ;
			$display("From UUT       --- > Dividend = %h , Divisor = %h , Quotient = %h , Remainder = %h",B,A,Q,R);
			$display("From TestBench --- > Dividend = %h , Divisor = %h , Quotient = %h , Remainder = %h",B,A,tempQ,tempR);
			if ( Q!= tempQ)
			$display("ERROR : Q was not obtained correctly" );
			if ( R!= tempR)
			$display("ERROR : R was not obtained correctly" );
		end
		
		$display("Test end at time = ", $time);
	
end
endmodule
