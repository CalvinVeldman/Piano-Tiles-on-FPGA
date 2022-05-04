module slowClk(input logic clk,
					output logic slowClk);
										
logic [27:0] counter;					
					
always@(posedge clk)
begin
	counter <= counter + 1;
		if ( counter >= 15_000_000)
			begin
				counter <= 0;
				slowClk <= ~slowClk;
         end
		end
endmodule  
