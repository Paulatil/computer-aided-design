`timescale 1ns / 100ps
 //////////////////
  // THE CONTROLLER MODULE
////////////////////////

module controller_unit (clk, clear, LB_M, Done, Q_shift_in, Sel, A_sig, B_sig, M_sig, N_sig, R_sig, Q_sig);

 input clk;
 input clear;
 input LB_M;
 output reg Done;
 output reg Q_shift_in;
 output reg Sel;
 output reg [2:0] A_sig, B_sig, M_sig, N_sig, R_sig, Q_sig;

reg [3:0] state;
 parameter   clearS = 4'b0000, ShiftS = 4'b0001, HoldS = 4'b0010, SubtractS = 4'b0011, WaitS = 4'b0100, TestS = 4'b0101,
             NoOverflowS = 4'b0110, OverflowS = 4'b0111, EndS = 4'b1000, DoneS = 4'b1001;

  reg [4:0] Count;

 always @ (posedge clk, posedge clear)
 begin
       if (clear == 1) state <= clearS;
          else 
            begin
                   case (state)
                         clearS: begin
                          state <= ShiftS;
                          A_sig <= 3'b010;      // load A    
                          B_sig <= 3'b010;      //load B
                          M_sig <= 3'b100;     //clear M
                          N_sig <= 3'b100;    // clear N
                          R_sig <= 3'b100;   // clear R
                          Q_sig <= 3'b100;  // clear Q
                          Count <= 0;     // initialize count
                          Done <= 0;
                           Q_shift_in <= 0;
                          end
   
                 ShiftS:  begin
                            state <= HoldS; //next state stores
                          A_sig <= 3'b000;      // hold A    
                          B_sig <= 3'b001;      //shift B
                          M_sig <= 3'b001;     //shift M
                          N_sig <= 3'b000;    // hold N
                          R_sig <= 3'b000;   // hold R
                          Q_sig <= 3'b000;  // hold Q
                          end

                    HoldS: begin
                            state <= SubtractS;
                          B_sig <= 3'b000;      //holds B
                          M_sig <= 3'b000;     //holds M
                          N_sig <= 3'b010;    // loads N
                         Sel <= 1;       //select A_out
                        end
  
                     SubtractS: begin
                             state <= WaitS;
                          M_sig <= 3'b010;     //loads M with A_out
                          N_sig <= 3'b000;    // holds N
                         end
 
                     WaitS: begin
                            state <= TestS;
                           M_sig <= 3'b000;
                          end
 
                    TestS: begin
                          M_sig <= 3'b000; //holds M
                          Sel <= 0;     //select temp
                          if (LB_M == 1'b1) state <= OverflowS;  //go to overflow if A[7] = 1
                           else if (LB_M == 1'b0) state <= NoOverflowS;  //go to NoOverflow if A[7] = 0
                          end

                    OverflowS: begin
                        state <= EndS;
                        M_sig <= 3'b010;
                        Q_shift_in <= 0;
                         Count <= Count+1;
                        end

                      NoOverflowS: begin
                            state <= EndS;
                             M_sig <= 3'b000;  //hold M
                             Q_shift_in <= 1;
                             Count <= Count+1;
                           end

                       EndS: begin
                           M_sig <= 3'b000;  //hold M
                           Q_sig <= 3'b001;   //shift Q
                            if (Count == 16) state <= DoneS;
                                else state = ShiftS;
                           end

                        DoneS: begin
                           state <= DoneS;
                            R_sig <= 3'b010; //load R
                            Q_sig <= 3'b000;   //hold Q
                             Done <= 1;
                           end

                 endcase
         end
   end
 endmodule
