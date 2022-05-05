module  screenHighScore (input [9:0] drawX, drawY, 
						  input Clk,
                    input [5:0] score,
                    output to_color);    
    //score x30
    //screen is 640 x 480
    //char1 location (14, 2)
    //char0 location (26, 2)                
font_rom first_digit(    .addr(address0), .data(data0)    );
font_rom second_digit(    .addr(address1), .data(data1)    );
    logic colorbit0, colorbit1;
    logic [4:0] char0, char1;
    logic [5:0] charcode0, charcode1;
    logic [7:0] data0, data1;
    logic [9:0] address0, address1, drawYmod, drawXmod0, drawXmod1, drawXmod3;

    assign         char1 = score/4'd10;
    //assign        drawXmod0 = drawX - 6'd26;
    //assign        drawXmod1 = drawX - 6'd14;
    assign        charcode0 = char0 + 10'h30;
    assign        charcode1 = char1 + 10'h30;
    assign        drawXmod3 = drawX - 6'd8;
    always_comb 
    begin
            char0 = score - char1 * 4'd10;
    end
    
    assign        address0 = {charcode0, drawY[3:0]};
    assign        address1 = {charcode1, drawY[3:0]};
//    assign        colorbit0 = data0[drawXmod0[2:0]];
//    assign        colorbit1 = data1[drawXmod1[2:0]];
//	assign colorbit0 = data0[7 - drawXmod3[2:0]];
//	assign colorbit1 = data1[7 - drawX[2:0]];
	
    always_ff @ (posedge Clk)
    begin
        if((drawY >= 0 && drawY < 16) && (drawX >= 24 && drawX < 32))
            begin
                colorbit1 <= data1[7 - drawX[2:0]];
            end
			else 
				colorbit1 <= 0;
    end
	 
	 
	 always_ff @ (posedge Clk)
    begin
        if((drawY >= 0 && drawY < 16) && (drawX >= 32 && drawX < 40))
            begin
                colorbit0 <= data0[7 - drawX[2:0]];
            end
			else
				colorbit0 <= 0;
    end
	 
	 assign to_color = colorbit0 || colorbit1;
	 

endmodule