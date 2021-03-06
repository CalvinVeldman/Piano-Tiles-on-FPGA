module  ball2 ( input Reset, frame_clk, newNote, kill,
					input [7:0] keycode,
					input [3:0] speed,
               output [9:0]  BallX, BallY, BallS );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
    parameter [9:0] Ball_X_Center=240;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=80;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    assign Ball_Size = 75;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Min;
				Ball_X_Pos <= Ball_X_Center;
        end
         
		  else if (newNote)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 3 + speed; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Min;
				Ball_X_Pos <= Ball_X_Center;
        end
		  
		  else if(kill)
		  begin
				Ball_Y_Motion <= 0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center + 321;
				Ball_X_Pos <= Ball_X_Center;
		  end
	
        else 
        begin 
				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )	 // Ball is at the bottom edge, BOUNCE!
				 begin
					  Ball_Y_Motion <= 0;  // 2's complement.
					  Ball_X_Motion <= 0;
					  end
//					  
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
//				 begin
//					  Ball_Y_Motion <= Ball_Y_Step;
//					  Ball_X_Motion <= 0;
//					  end
//				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//				  begin
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//					  Ball_Y_Motion <= 0;
//					  end
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//				 begin
//					  Ball_X_Motion <= Ball_X_Step;
//					  Ball_Y_Motion <= 0;
//					  end
//					  
				 else 
				 begin
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
				 
//				 case (keycode)
//					8'h04 : begin
//
//								Ball_X_Motion <= -1;//A
//								Ball_Y_Motion<= 0;
//							  end
//					        
//					8'h07 : begin
//								
//					        Ball_X_Motion <= 1;//D
//							  Ball_Y_Motion <= 0;
//							  end
//
//							  
//					8'h16 : begin
//
//					        Ball_Y_Motion <= 1;//S
//							  Ball_X_Motion <= 0;
//							 end
//							  
//					8'h1A : begin
//					        Ball_Y_Motion <= -1;//W
//							  Ball_X_Motion <= 0;
//							 end	  
//					default: ;
//			   endcase
				 end
				
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
				
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallS = Ball_Size;
    

endmodule