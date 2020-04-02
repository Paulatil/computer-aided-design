`timescale 1ns / 1ns
module mod6_counter_data_flow (I,Q,CLK,CLR,LC);      //port list identification

 input [2:0]I;          // the externsl inputs of the counter
 input CLK,CLR,LC;     // the control signals of the events that occur 
output reg [2:0] Q;   // the Q holds values and also the external output of the counter
wire d0,d1,d2;       // the internal inputs of the FF that make up the counter


  assign d0 = LC&I[0] | ~LC&~Q[0];   // the combinational logic of the loading/counting sequence                       
  assign d1 = LC&I[1] | ~LC&(Q[1]&~Q[0]|~Q[2]&~Q[1]&Q[0]);   
  assign d2 = LC&I[2] | ~LC&(Q[2]&~Q[0]|Q[1]&Q[0]);

  always @(posedge CLK or negedge CLR)    // this creates an infinite loop for execution at every start of simulation 
   begin
        if(CLR==0)            // the clear signal takes precendence 
           Q= 3'b000;         // clears the output to 000
          else
     begin
         Q[0]=d0;    // assign the ouput Q the new values at the next clock cycle
         Q[1]=d1;
         Q[2]=d2;
    end
end

  endmodule
