module lfsr
   #(parameter BITS = 21)
   (
    input             clk,
    input             rst,
	 input				 [9:0] SW,
    output reg [47:0] data
    );

//   reg [4:0] data_next;
//   always_comb begin
//      data_next = data;
//      repeat(BITS) begin
//         data_next = {(data_next[4]^data_next[1]), data_next[4:1]};
//      end
//   end
//
//   always_ff @(posedge clk or posedge rst) begin
//      if(rst)
//         data <= 5'h1f;
//      else
//         data <= data_next;
//   end


decoder dec1(data[7:0], {SW[0], SW[6], SW[1]});
decoder dec2(data[15:8], {SW[8], SW[9], SW[4]});
decoder dec3(data[23:16], {SW[5], SW[3], SW[2]});
decoder dec4(data[31:24], {SW[1], SW[8], SW[7]});
decoder dec5(data[39:32], {SW[4], SW[0], SW[9]});
decoder dec6(data[47:40], {SW[3], SW[5], SW[6]});


endmodule