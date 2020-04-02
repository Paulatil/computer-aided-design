module test(A,B,C,D,Y);
input A,B,C,D;
output Y;
wire E,F,G,H;
OR2_B U2(.A(A),.B(B),.Z(E));
INVERT_A U1(.A(C),.Z(F));
AND2_B U3(.A(E),.B(C),.Z(G));
AND2_B U4(.A(F),.B(D),.Z(H));
OR2_B U5(.A(G),.B(H),.Z(Y));
endmodule
