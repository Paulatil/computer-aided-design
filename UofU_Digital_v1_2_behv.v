// Verilog HDL for "UofU_Digital", "and3" "behavioral"

module AND3X1 (Y, A, B, C);
    output Y;
    input A;
    input B;
    input C;

   and _i0(Y, A, B, C);
   
   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital", "AOI21X1" "behavioral"

module AOI21X1 (Y, A, B, C);
    output Y;
    input A;
    input B;
    input C;

   wire   Ymid;
   
   and _i0(Ymid, A, B);
   nor _i1(Y, Ymid, C);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
   endspecify
   
endmodule

module AOI22X1 (Y, A, B, C, D);
    output Y;
    input A;
    input B;
    input C;
    input D;

    wire Ymid1, Ymid2;

    and _i0(Ymid1, A, B);
    and _i1(Ymid2, C, D);
    nor _i2(Y, Ymid1, Ymid2);

    specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
      (D => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "bufX1" "behavioral"

module BUFX2 (Y, A);
    output Y;
    input A;

   buf (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "bufX4" "behavioral"

module BUFX4 (Y, A);
    output Y;
    input A;

   buf (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "bufX1" "behavioral"

module BUFX8 (Y, A);
    output Y;
    input A;

   buf (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "bufX1" "behavioral"

module BUFX8 (Y, A);
    output Y;
    input A;

   buf (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "bufX1" "behavioral"

module BUFX8 (Y, A);
    output Y;
    input A;

   buf (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "dff" "behavioral"

module DCBNX1 (CLR, D, CLK, Q, QB);
    input CLR;
    input D;
    input CLK;
    output Q;
    output QB;

reg Q_i, QB_i;

always @(negedge CLK or negedge CLR)
	if (CLR == 0) 
	    begin
		Q_i = 1'b0;
		QB_i = 1'b1;
	    end
	else
	    begin 
		Q_i = D;
		QB_i = ~D;
	    end

buf _i0 (Q, Q_i);
buf _i1 (QB, QB_i);

	specify
	(CLK *> Q) = (1.0, 1.0);
	(CLK *> QB) = (1.0, 1.0);
	(CLR *> Q) = (1.0, 1.0);
	(CLR *> QB) = (1.0, 1.0);
	$setup(D, negedge CLK, 0.0);
	$hold(negedge CLK, D, 0.0);
	$hold(negedge CLK, CLR, 0.0);
	$recovery(negedge CLR, negedge CLK, 0.0);
	endspecify

endmodule
// Verilog HDL for "UofU_Digital", "dff" "behavioral"

module DCBX1 (CLR, D, CLK, Q, QB);
    input CLR;
    input D;
    input CLK;
    output Q;
    output QB;

reg Q_i, QB_i;

always @(posedge CLK or negedge CLR)
	if (CLR == 0) 
	    begin
		Q_i = 1'b0;
		QB_i = 1'b1;
	    end
	else
	    begin 
		Q_i = D;
		QB_i = ~D;
	    end

buf _i0 (Q, Q_i);
buf _i1 (QB, QB_i);

	specify
	(CLK *> Q) = (1.0, 1.0);
	(CLK *> QB) = (1.0, 1.0);
	(CLR *> Q) = (1.0, 1.0);
	(CLR *> QB) = (1.0, 1.0);
	$setup(D, posedge CLK, 0.0);
	$hold(posedge CLK, D, 0.0);
	$hold(posedge CLK, CLR, 0.0);
	$recovery(negedge CLR, posedge CLK, 0.0);
	endspecify

endmodule
// Verilog HDL for "UofU_Digital", "dffn" "behavioral"

module DCNX1 (CLR, D, CLK, Q);
    input CLR;
    input D;
    input CLK;
    output Q;

reg Q_i;

always @(negedge CLK or negedge CLR)
	if (CLR == 0) 
	    begin
		Q_i = 1'b0;
	    end
	else
	    begin 
		Q_i = D;
	    end

buf _i0 (Q, Q_i);

	specify
	(CLK *> Q) = (1.0, 1.0);
	(CLR *> Q) = (1.0, 1.0);
	$setup(D, negedge CLK, 0.0);
	$hold(negedge CLK, D, 0.0);
	$hold(negedge CLK, CLR, 0.0);
	$recovery(negedge CLR, negedge CLK, 0.0);
	endspecify

endmodule
// Verilog HDL for "UofU_Digital", "dff" "behavioral"

module DCX1 (CLR, D, CLK, Q);
    input CLR;
    input D;
    input CLK;
    output Q;

reg Q_i;

always @(posedge CLK or negedge CLR)
	if (CLR == 0) 
	    begin
		Q_i = 1'b0;
	    end
	else
	    begin 
		Q_i = D;
	    end

buf _i0 (Q, Q_i);

	specify
	(CLK *> Q) = (1.0, 1.0);
	(CLR *> Q) = (1.0, 1.0);
	$setup(D, posedge CLK, 0.0);
	$hold(posedge CLK, D, 0.0);
	$hold(posedge CLK, CLR, 0.0);
	$recovery(negedge CLR, posedge CLK, 0.0);
	endspecify

endmodule
// Verilog HDL for "UofU_Digital", "eninv" "behavioral"

module ENINVX1 (Y, A, EN);
    output Y;
    input A;
    input EN;

 notif1(Y, A, EN);

   specify
	(A => Y) = (1.0, 1.0);
	(EN => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital", "eninv" "behavioral"

module ENINVX2 (Y, A, EN);
    output Y;
    input A;
    input EN;

 notif1(Y, A, EN);

   specify
	(A => Y) = (1.0, 1.0);
	(EN => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital", "invX8" "behavioral"

module INVX16 (Y, A);
    output Y;
    input A;

   not _i0 (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "invX1" "behavioral"

module INVX1 (Y, A);
    output Y;
    input A;

   not _i0 (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "invX2" "behavioral"

module INVX2 (Y, A);
    output Y;
    input A;

   not _i0 (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "invX4" "behavioral"

module INVX4 (Y, A);
    output Y;
    input A;

   not _i0 (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "invX8" "behavioral"

module INVX8 (Y, A);
    output Y;
    input A;

   not _i0 (Y, A);

   specify
      (A => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "latch_ng_nip" "behavioral"

module LCX1 (Q, CLR, D, G);
    output Q;
    input CLR;
    input D;
    input G;
  
   reg Q_i;
   
   always @(CLR or G or D)
     if(CLR == 0)
       Q_i = 1'b0;
     else if (G == 1)
       Q_i = ~D;

// The buf allows the path delays to work
   buf(Q, Q_i);

   specify
      (G *> Q) = (1.0, 1.0);
      (CLR *> Q) = (1.0, 1.0);
      $setup(D, posedge G, 0.0);
      $hold(posedge G, D, 0.0);
      $hold(posedge G, CLR, 0.0);
      $recovery(negedge CLR, posedge G, 0.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "latch_ng_nip" "behavioral"

module LCNX1 (Q, CLR, D, G);
    output Q;
    input CLR;
    input D;
    input G;
  
   reg Q_i;
   
   always @(CLR or G or D)
     if(CLR == 0)
       Q_i = 1'b0;
     else if (G == 0)
       Q_i = ~D;

// The buf allows the path delays to work
   buf(Q, Q_i);

   specify
      (G *> Q) = (1.0, 1.0);
      (CLR *> Q) = (1.0, 1.0);
      $setup(D, posedge G, 0.0);
      $hold(posedge G, D, 0.0);
      $hold(posedge G, CLR, 0.0);
      $recovery(negedge CLR, posedge G, 0.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "mux2_inv" "behavioral"

module MUX2NX1 (Y, A, B, S);
    output Y;
    input A;
    input B;
    input S;

   wire   Sbar, Amid, Bmid, Ymid;
   
   not _i0 (Sbar, S);
   and _i1 (Amid, A, Sbar);
   and _i2 (Bmid, B, S);
   nor _i3 (Y, Amid, Bmid);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
      (S => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital", "mux2_inv" "behavioral"

module MUX2X2 (Y, A, B, S);
    output Y;
    input A;
    input B;
    input S;

   wire   Sbar, Amid, Bmid, Ymid;
   
   not _i0 (Sbar, S);
   and _i1 (Amid, A, Sbar);
   and _i2 (Bmid, B, S);
   nor _i3 (Ymid, Amid, Bmid);
   not _i4 (Y, Ymid);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
      (S => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital_v1_1", "nand2" "behavioral"

module NAND2X1 (Y, A, B);
    output Y;
    input A;
    input B;

   nand _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital_v1_1", "nand2" "behavioral"

module NAND2X2 (Y, A, B);
    output Y;
    input A;
    input B;

   nand _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "and3" "behavioral"

module NAND3X1 (Y, A, B, C);
    output Y;
    input A;
    input B;
    input C;

   nand _i0(Y, A, B, C);
   
   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
   endspecify
   
endmodule
// Verilog HDL for "UofU_Digital", "nor2" "behavioral"

module NOR2X1 (Y, A, B);
    output Y;
    input A;
    input B;

   nor _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "nor2" "behavioral"

module NOR2X2 (Y, A, B);
    output Y;
    input A;
    input B;

   nor _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "nor3" "behavioral"

module NOR3X1 (Y, A, B, C);
    output Y;
    input A;
    input B;
    input C;
   
   nor _i0(Y, A, B, C);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
   endspecify
endmodule
// Verilog HDL for "UofU_Digital", "OAI" "behavioral"

module OAI21X1 (Y, A, B, C);
    output Y;
    input A;
    input B;
    input C;

   wire   Ymid;
  
   or _i0(Ymid, A, B);
   nand _i1(Y, Ymid, C);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
   endspecify
   
endmodule

module OAI22X1 (Y, A, B, C, D);
    output Y;
    input A;
    input B;
    input C;
    input D;

    wire Ymid1, Ymid2;

    or _i0(Ymid1, A, B);
    or _i1(Ymid2, C, D);
    nand _i2(Y, Ymid1, Ymid2);

    specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);      
      (C => Y) = (1.0, 1.0);
      (D => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "tiehi" "behavioral"

module TIEHI (Y);
    output Y;

   assign  Y = 1'b1;
   
endmodule
// Verilog HDL for "UofU_Digital", "tielo" "behavioral"

module TIELO (Y);
    output Y;

   assign  Y = 1'b0;
   
endmodule
// Verilog HDL for "UofU_Digital_v1_2", "XNOR2X1" "behavioral"

module XNOR2X1 (Y, A, B);
    output Y;
    input A;
    input B;

   xnor _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
// Verilog HDL for "UofU_Digital", "xor2" "behavioral"

module XOR2X1 (Y, A, B);
    output Y;
    input A;
    input B;

   xor _i0(Y, A, B);

   specify
      (A => Y) = (1.0, 1.0);
      (B => Y) = (1.0, 1.0);
   endspecify

endmodule
