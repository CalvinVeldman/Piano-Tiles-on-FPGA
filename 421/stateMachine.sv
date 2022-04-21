module songState(input logic Reset, unpause, start,
					  output logic block1, block2, block3, block4);

enum logic [5:0] {  Halted, 
						starting,
						pause1,
						pause2,
						pause3,
						pause4,
						pause5,
						pause6,
						pause7,
						pause8,
						note1,
						note2,
						note3,
						note4,
						note5,
						note6,
						note7,
						note8}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= start;
		else 
			State <= Next_state;
	end
   
	always_comb begin 
		Next_state = state;
		block1 = 0;
		block2 = 0;
		block3 = 0;
		block4 = 0;
		unique case (State)
			starting : 
				if(start)
					Next_state = note1;
			note1	:
				Next_state = pause1;
			pause1 :
				Next_state = note2;
			note2	:
				Next_state = pause2;
			pause2 :
				Next_state = note3;
			note3 :
				Next_state = pause3;
			pause3 :
				Next_state = note4;
			note4 :
				Next_state = pause4;
			pause4 :
				Next_state = note5;
			note5 :
				Next_state = pause5;
			pause5 :
				Next_state = note6;
			note6 :
				Next_state = pause6;
			pause6 :
				Next_state = note7;
			note7	:
				Next_state = pause7;
			pause7 :
				Next_state = note8;
			note8	:
				Next_state = Halted;
			Halted :
				if(Reset)
					Next_state = starting;
			default : ;
			
		endcase	
		
		case (State)
			starting : ;
			Halted : ;
			note1  : block1 = 1;
			pause1 : ;
			note2  : block2 = 1;
			pause2 : ;
			note3  : block3 = 1;
			pause3 : ;
			note4  : block4 = 1;
			pause4 : ;
			note5  : block3 = 1;
			pause5 : ;
			note6  : block2 = 1;
			pause6 : ;
			note7  : block1 = 1;
			pause7 : ;
			note8  : block4 = 1;
			default : ;
		endcase
	end
endmodule
				
				