 `timescale 1ns / 1ns

module mod6_counter_tb();

reg [2:0] I;
reg clk,clr,lc;
wire [2:0] Q;


  MOD6_counter_behave UUT (.CLK(clk), .CLR(clr), .LC(lc),.I(I),.Q(Q));
 //mod6_counter_data_flow UUT (.CLK(clk), .CLR(clr), .LC(lc),.I(I),.Q(Q));

initial
  begin
    clk=0;
      clr=1;
      lc=0;
      I=3'b000;
  end

always
      #10 clk=~clk;

initial
  begin  

   clr=1;
 #20
      lc=1;
      I=3'b001;
 #20
  
              if(Q!==I)
                        $display("ERROR!: the ouput Q isnt loaded with %b", I);
                else $display ("the output Q is loaded with %b", I);
    #40 clr=0;
    #20 clr=1;
#20
            if(Q!==0)
                        $display("ERROR!: the ouput Q isnt cleared to 000");
                else $display ("the output Q has been cleared to 000");
    
   #20 
    I=3'b010;
  #20
            if(Q!==I)
                        $display("ERROR!: the ouput Q isnt loaded with %b", I);
                else $display ("the output Q is loaded with %b", I);

  #40
   I=3'b101;
  lc=0;    
 #20
         if(Q!==I)
                        $display("ERROR!: the ouput Q isnt loaded with %b", I);
                else $display ("the output Q is loaded with %b", I);

 #40 clr=0;
 #20 clr=1;
 #20
           if(Q!==0)
                        $display("ERROR!: the ouput Q isnt cleared to 000");
                else $display ("the output Q has been cleared to 000");
    
     wait(Q==3'b101);
        #20   
                     if(Q!=Q+1)
                        $display("ERROR!: the output Q isnt incremeting to %b", Q);
                else $display ("the output Q is incrementing to %b", Q);         
                 $display($time, "<<end of simulation>>");

  end

 endmodule