module processor (sysclk, data_in, data_out, data_valid,
						ADC_SCK, SW, HEX0, HEX1, HEX2, HEX3);

	input				sysclk;
	input [9:0]		data_in;
	input				data_valid;
	input 			ADC_SCK;
	input [9:0]	SW;
	
	output [9:0] 	data_out;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire				sysclk;
	wire pul;
	wire [15:0] ctr;
	wire [12:0] addr, delayAddr;
	
	reg [9:0] 		data_out;
	wire [9:0]		x,y;
	wire [8:0] 		q;
	
	wire [12:0] timeout;

	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;

	assign x = data_in[9:0] - ADC_OFFSET;
	
	///////////////////////////////////////////////////////////
	
	assign timeout = {SW[8:0],4'b0};
	
	pulse_gen durain (pul, data_valid, sysclk);

	counter_16 banana (sysclk, pul, 1'b0, ctr);
	
	assign addr = ctr[12:0];
	
	assign delayAddr = addr+ timeout;
	
	RAM watermelon (sysclk, y[9:1], addr, pul, delayAddr, pul, q);
	
	assign y = x - {q[8], q[8:1], 1'b0};
	
	display pineaple (SW, HEX0, HEX1, HEX2, HEX3, HEX4);
	
	///////////////////////////////////////////////////////////
	
	always @(posedge sysclk)
		data_out <=  y + DAC_OFFSET;
		
endmodule 

