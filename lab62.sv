//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 
			
);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST,
			b1, b2, b3, b4, slowClk, kill1, kill2, kill3, kill4, toColor1, toColor2, screen;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0, speed; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [9:0] ballxsig2, ballysig2, ballsizesig2;
	logic [9:0] ballxsig3, ballysig3, ballsizesig3;
	logic [9:0] ballxsig4, ballysig4, ballsizesig4;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode, score, highScore, shiftred, shiftgreen, shiftblue;
	logic [23:0] debug;
	logic [47:0] randVal;
//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	
	HexDriver hex_driver5 (debug[7:4], HEX5[6:0]);
	assign HEX5[7] = 1'b1;
	
	
	
	
	HexDriver hex_driver4 (debug[3:0], HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (highScore[7:4], HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	
	
	HexDriver hex_driver2 (highScore[3:0], HEX2[6:0]);
	assign HEX2[7] = 1'b1;
	
	
	
	HexDriver hex_driver1 (score[7:4], HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (score[3:0], HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	
	//fill in the hundreds digit as well as the negative sign
	//assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	//assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);			//wtf does concatanate with only one thing even mean?? ?? ?? ?? ?? ?? ??

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.
vga_controller lord_of_vga( 				.Clk(MAX10_CLK1_50),       // 50 MHz clock
													.Reset(Reset_h),     // reset signal
													.hs(VGA_HS),        // Horizontal sync pulse.  Active low
													.vs(VGA_VS),        // Vertical sync pulse.  Active low
													.pixel_clk(VGA_Clk), // 25 MHz pixel clock output
													.blank(blank),     // Blanking interval indicator.  Active low.
													.sync(sync),      // Composite Sync signal.  Active low.  We don't use it in this lab,
												             //   but the video DAC on the DE2 board requires an input for it.
													.DrawX(drawxsig),     // horizontal coordinate
													.DrawY(drawysig) );


color_mapper 	mapper_of_colors( .BallX(ballxsig), .BallY(ballysig), .DrawX(drawxsig), .DrawY(drawysig), .Ball_size(ballsizesig),
											.BallX2(ballxsig2), .BallY2(ballysig2),
											.BallX3(ballxsig3), .BallY3(ballysig3),
											.BallX4(ballxsig4), .BallY4(ballysig4),
											.Red(Red), .Green(Green), .Blue(Blue), .blank(blank),
											.keycode(keycode), .score(score), .toColor1(toColor1), .toColor2(toColor2),
											.shred(shiftred), .shblue(shiftblue), .shgreen(shiftgreen),
											.speed(speed), .screen(screen), .Clk(MAX10_CLK1_50));

ball block_1( .Reset(Reset_h), 
					.frame_clk(VGA_VS),//FIGUREITOUT
					.keycode(keycode),
               .BallX(ballxsig), 
					.BallY(ballysig), 
					.BallS(ballsizesig),
					.newNote(b1),
					.kill(kill1),
					.speed(speed));
ball2 block_2( .Reset(Reset_h), 
					.frame_clk(VGA_VS),//FIGUREITOUT
					.keycode(keycode),
               .BallX(ballxsig2), 
					.BallY(ballysig2), 
					.BallS(ballsizesig2),
					.newNote(b2),
					.kill(kill2),
					.speed(speed));
ball3 block_3( .Reset(Reset_h), 
					.frame_clk(VGA_VS),//FIGUREITOUT
					.keycode(keycode),
               .BallX(ballxsig3), 
					.BallY(ballysig3), 
					.BallS(ballsizesig3),
					.newNote(b3),
					.kill(kill3),
					.speed(speed));
ball4 block_4( .Reset(Reset_h), 
					.frame_clk(VGA_VS),//FIGUREITOUT
					.keycode(keycode),
               .BallX(ballxsig4), 
					.BallY(ballysig4), 
					.BallS(ballsizesig4),
					.newNote(b4),
					.kill(kill4),
					.speed(speed));		

songState song(.Reset(Reset_h),
					.Clk(slowClk), 
					.fastClk(MAX10_CLK1_50),
					.start(1'b1), 
					.block1(b1), 
					.block2(b2), 
					.block3(b3), 
					.block4(b4),
					.debug(debug),
					.buttons(KEY),
					.keycode(keycode),
					.randVal(randVal),
					.kill1(kill1),
					.kill2(kill2),
					.kill3(kill3),
					.kill4(kill4),
					.speed(speed),
					.screen(screen));			
slowClk rhythm(.clk(MAX10_CLK1_50), .slowClk(slowClk));	

lfsr random(.data(randVal), .clk(MAX10_CLK1_50), .rst(Reset_h), .SW(SW));

screenScore scoreMaker(.Clk(MAX10_CLK1_50), .drawX(drawxsig), .drawY(drawysig), .score(score), .to_color(toColor1));

screenScore highScoreMaker(.Clk(MAX10_CLK1_50), .drawX(drawxsig), .drawY(drawysig), .score(highScore), .to_color(toColor2));

shifter shifty (.DrawX(drawxsig), .DrawY(drawysig), .red(shiftred), .green(shiftgreen), .blue(shiftblue));

initial begin
highScore = 0;
end

always_ff @ (posedge MAX10_CLK1_50) begin
if(score > highScore)
	highScore <= score;
end
			
					
endmodule
