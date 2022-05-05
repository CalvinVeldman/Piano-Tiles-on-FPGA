module shifter(input [9:0] DrawY, input [8:0] DrawX,
                    output [7:0] red, green, blue);

logic [6:0] counter;
logic [6:0] flag;

    always_ff @ (posedge DrawX) 
        begin
            if(DrawX == 0 && DrawY == 0 && flag)begin
					if (counter == 7'b111_1110)
						flag <= -1;
               if(counter == 1)
						flag <= 1;
					counter <= counter + flag;	
				end
        end      

always_comb begin		  
                red = {DrawX[3:0], DrawY[3:0]};
                blue = {DrawY[3:0], DrawX[3:0]};
                green ={counter ,DrawY[0]};
					 
end				 
endmodule
