 `timescale 1ns / 1ns

module MOD6_counter_behave (I,Q,CLK,CLR,LC);   //port list identification

 input [2:0]I;                       // the external iut of the counter
 input CLK,CLR,LC;                   // the control signals of the counter
output reg [2:0] Q;                 // holds values and also the external output of the counter
                  

 always @ (posedge CLK or negedge CLR) // this executes in a loop  
begin
    if (CLR==0)                         // the clear signal takes precedence
         Q= 3'b000;                  // clear the output to 000

    else if (LC==1)                  // this loads the external input I to the output Q 
         Q<=I;
 
    else if (Q<=5)                   // the counting sequence from 0 to 5
          Q<=Q+1;    
   
    else 
          Q<=Q;   // the output Q returns to 000
end


 endmodule    