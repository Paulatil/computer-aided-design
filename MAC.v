module MAC(A, B, C, CLK, RST);

input CLK,RST;
input[3:0] A, B;
output reg[7:0] C;

wire[7:0] M, M1;


   assign M = A * B;
   assign M1 = C + M;

 always@(posedge CLK)
begin
       if(RST)
           C <= 0;
        else
           C <= M1;
 end
         
endmodule
