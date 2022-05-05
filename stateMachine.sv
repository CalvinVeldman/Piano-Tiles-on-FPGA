module songState(input logic Reset, Clk, fastClk, start,
						input logic [7:0] keycode,
						input logic [1:0] buttons,
						input logic [47:0] randVal,
						output [24:0] debug,
						output logic [3:0] speed,
					   output logic block1, block2, block3, block4, 
										 kill1, kill2, kill3, kill4, screen);

enum logic [6:0] {  Halted, 
						starting,
						pause1,
						pause2,
						pause3,
						pause4,
						pauseFinal,
						home,
						endcheck,
						note1,
						note2,
						note3,
						note4
						}   State, Next_state;   // Internal state logic

logic [15:0] numNotes;						
logic [24:0] pauseCounter;			
logic [24:0] counterCheck;
logic [3:0] flag, blockflag;
assign counterCheck = 1;
assign debug = numNotes;
assign speed = 1 + numNotes / 2;
	
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= starting;
		else 
			State <= Next_state;
	
		pauseCounter <= 0;
		case (State)
					pause1, pause2, pause3, pause4, pauseFinal:
				begin					
					pauseCounter <= pauseCounter + 1;
				end
					starting:
				begin
					numNotes <= 0;
				end
					note1, note2, note3, note4:
				begin
					numNotes <= numNotes + 1;
				end
		endcase
		
	end
	
	always_ff @ (posedge fastClk)
	begin
		
		if(keycode == 8'h09) begin
				flag[3] <= 1;
				kill4 <= 1;
		end
		if(keycode != 8'h09 && flag[3]) begin
				
				flag[3] <= 0;
				kill4 <= 0;
		end
		
		if(keycode == 8'h07) begin
				flag[2] <= 1;
				kill3 <= 1;
		end
		if(keycode != 8'h07 && flag[2]) begin
				
				flag[2] <= 0;
				kill3 <= 0;
		end
		
		if(keycode == 8'h16) begin
				flag[1] <= 1;
				kill2 <= 1;
		end
		if(keycode != 8'h16 && flag[1]) begin
				
				flag[1] <= 0;
				kill2 <= 0;
		end
		
		if(keycode == 8'h04) begin
				flag[0] <= 1;
				kill1 <= 1;
		end
		if(keycode != 8'h04 && flag[0]) begin
				
				flag[0] <= 0;
				kill1 <= 0;
		end
	
	
	end
	
	
	
	always_comb begin 
		Next_state = State;
		
		unique case (State)
			starting : 
				if(keycode == 8'h2c) begin
					Next_state = home;
				end
			home	:				
				if(randVal[2*numNotes +: 2] == 2'b00)
					Next_state = pause1;
				else if(randVal[2*numNotes +: 2] == 2'b01)
					Next_state = pause2;
				else if(randVal[2*numNotes +: 2] == 2'b10)
					Next_state = pause3;
				else
					Next_state = pause4;
			endcheck :
				if(numNotes >= 20)
					Next_state = pauseFinal;
				else
					Next_state = home;
			pause1 :
				if(pauseCounter >= counterCheck)
				Next_state = note1;
			note1  :
				Next_state = endcheck;
			pause2 :
				if(pauseCounter >= counterCheck)
					Next_state = note2;
			note2	:
				Next_state = endcheck;	
			pause3 :
				if(pauseCounter >= counterCheck)
					Next_state = note3;
			note3 :
				Next_state = endcheck;
			pause4 :
				if(pauseCounter >= counterCheck)
					Next_state = note4;					
			note4 :
				Next_state = endcheck;			
			pauseFinal :
				if(pauseCounter >= counterCheck)
					Next_state = starting;
			default : ;
			
		endcase	
end

always_comb begin	
		block1 = 0;
		block2 = 0;
		block3 = 0;
		block4 = 0;
		screen = 0;
		case (State)
			starting : screen = 1;
			Halted : ;
			home   : ;
			note1  : 
				begin 
					block1 = 1;
				end
			pause1 : ;
			note2  : 
				begin 
					block2 = 1;
					//numNotes++;
				end
			pause2 : ;
			note3  : 
				begin 
					block3 = 1;
					//numNotes++;
				end 
			pause3 : ;
			note4  : 
				begin 
					block4 = 1;
					//numNotes++;
				end
			pause4 : ;
			pauseFinal : ;
			endcheck : ;
			default : ;
		endcase
	end
endmodule
				
				