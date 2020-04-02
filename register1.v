module Reg(I, Q, CLK, RST);
input[8:0] I;
output reg[8:0] Q;
input CLK, RST;

 always@(posedge CLK or RST)
  begin
     if (RST==1)
        Q <= 0;
      else
        Q <= I;
    end
endmodule 