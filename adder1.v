module ADD(X, Y, S);

input[7:0] X;
input[8:0] Y;
output[8:0] S;

 assign S = Y + X;

endmodule