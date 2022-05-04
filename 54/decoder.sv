module decoder(output logic [7:0] out, input logic [2:0] in);

always @(in) begin
	case(in)
		3'b000 : out = 10001011;
		3'b001 : out = 00111111;
		3'b010 : out = 10110101;
		3'b011 : out = 00001001;
		3'b100 : out = 00110100;
		3'b101 : out = 10110101;
		3'b110 : out = 11010001;
		3'b111 : out = 01010010;
	endcase
end

endmodule
