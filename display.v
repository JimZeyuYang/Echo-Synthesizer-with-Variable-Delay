module display (jiji, HEX0, HEX1, HEX2, HEX3, HEX4);

	input [13:0]jiji;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	
	wire [19:0] result;
	wire [15:0] bcd;
	wire [3:0] BCD_0, BCD_1, BCD_2, BCD_3, BCD_4;
	
	mult haha (result, jiji, 11'h666);
	
	bin2bcd_16 bin0 ({6'b0,result[19:10]}, BCD_0, BCD_1, BCD_2, BCD_3, BCD_4);
	
	four_bit_hex_to_7seg   SEG0 (HEX0, BCD_0);
	four_bit_hex_to_7seg   SEG1 (HEX1, BCD_1);
	four_bit_hex_to_7seg   SEG2 (HEX2, BCD_2);
	four_bit_hex_to_7seg   SEG3 (HEX3, BCD_3);
	
endmodule
	
	
	