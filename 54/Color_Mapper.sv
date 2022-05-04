//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
														BallX2, BallY2, BallX3, BallY3,
														BallX4, BallY4,
							  input			[7:0] keycode,
							  input					Clk,
							  input			[3:0] speed,
                       output logic [7:0]  Red, Green, Blue, score
							  );
	//output logic			 kill1, kill2, kill3, kill4
    
    logic ball_on;
	 logic [3:0] flag;
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 
	 initial begin
	 score = 0;
	 end
	  
    always_comb
    begin:Ball_on_proc
         if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size) &&
			BallY <= 400)
            ball_on = 1'b1;
			else if ((DrawX >= BallX2 - Ball_size) &&
       (DrawX <= BallX2 + Ball_size) &&
       (DrawY >= BallY2 - Ball_size) &&
       (DrawY <= BallY2 + Ball_size) &&
			BallY2 <= 400)
				ball_on = 1'b1;
			else if ((DrawX >= BallX3 - Ball_size) &&
       (DrawX <= BallX3 + Ball_size) &&
       (DrawY >= BallY3 - Ball_size) &&
       (DrawY <= BallY3 + Ball_size) &&
			BallY3 <= 400)
				ball_on = 1'b1;
			else if ((DrawX >= BallX4 - Ball_size) &&
       (DrawX <= BallX4 + Ball_size) &&
       (DrawY >= BallY4 - Ball_size) &&
       (DrawY <= BallY4 + Ball_size) &&
			BallY4 <= 400)
				ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'hff;
        end 
		  
        else if((DrawX >= 155 && DrawX <= 165) 
						|| (DrawX >= 315 && DrawX <= 325) 
						|| (DrawX >= 475 && DrawX <= 485))	  
		  begin
				Red = 8'h00;
            Green = 8'hff;
            Blue = 8'h00;
		  end
		  
		  else if(
//						(DrawY >= 395 && DrawY <= 405)
						(DrawY >= 315 && DrawY <= 325))
		  begin 
            Red = 8'h00; 
            Green = 8'hff;
				Blue = 8'h00;
				//Blue = 8'h7f - (DrawX[9:4]);     
        end  
		  
		  else
        begin 
            Red = 8'h00; 
            Green = 8'h00;
				Blue = 8'h00;
				//Blue = 8'h7f - (DrawX[9:4]);     
        end      
    end 
	 
	 always_ff @ (posedge Clk)
	 begin:Scoring
		//a
		if(BallY >= 370 && BallY <= 399 && keycode == 8'h04)
			flag[0] <= 1;
		if(keycode != 8'h04 && flag[0]) begin
			score <= score + speed / 2;
			flag[0] <= 0;
		end
		//s
		if(BallY2 >= 370 && BallY2 <= 399 && keycode == 8'h16)
			flag[1] <= 1;
		if(keycode != 8'h16 && flag[1]) begin
			score <= score + speed / 2;
			flag[1] <= 0;
		end
		//d
		if(BallY3 >= 370 && BallY3 <= 399 && keycode == 8'h07)
			flag[2] <= 1;
		if(keycode != 8'h07 && flag[2]) begin
			score <= score + speed / 2;
			flag[2] <= 0;
		end
		//f
		if(BallY4 >= 370 && BallY4 <= 399 && keycode == 8'h09)
			flag[3] <= 1;
		if(keycode != 8'h09 && flag[3]) begin
			score <= score + speed / 2;
			flag[3] <= 0;
		end
		
//		if(keycode == 8'h09) begin
//				flag[3] <= 1;
//				kill4 <= 1;
//		end
//		if(keycode != 8'h09 && flag[3]) begin
//				
//				flag[3] <= 0;
//				kill4 <= 0;
//		end
//		
//		if(keycode == 8'h07) begin
//				flag[2] <= 1;
//				kill3 <= 1;
//		end
//		if(keycode != 8'h07 && flag[2]) begin
//				
//				flag[2] <= 0;
//				kill3 <= 0;
//		end
//		
//		if(keycode == 8'h16) begin
//				flag[1] <= 1;
//				kill2 <= 1;
//		end
//		if(keycode != 8'h16 && flag[1]) begin
//				
//				flag[1] <= 0;
//				kill2 <= 0;
//		end
//		
//		if(keycode == 8'h04) begin
//				flag[0] <= 1;
//				kill1 <= 1;
//		end
//		if(keycode != 8'h04 && flag[0]) begin
//				
//				flag[0] <= 0;
//				kill1 <= 0;
//		end
		
		
		
		
		
		
		
		
		
		if(keycode == 8'h2c)
			score <= 0;
		
		
	 end
    
endmodule
