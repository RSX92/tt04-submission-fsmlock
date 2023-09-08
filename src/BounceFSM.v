module BounceFSM
(
	input clk,
	input i_Rst,
	input i_CE,
	input i_set_data,
	input [3:0] iv_data,
	
	output [7:0] o_acknowledge

);

wire clk_2Hz;

m_FMD_password m_FMD_password
(
	.clk (clk),
	.i_Rst (i_Rst),
	.i_CE (clk_2Hz),
	.i_set_data (i_set_data),
	.iv_data (iv_data),
	
	.o_acknowledge (o_acknowledge)
);

m_Div_frec  
#(.div(26'd5_000_000)) //10 MHz to 2Hz out
Div_2Hz
(
	.clk (clk),
	.i_Rst (i_Rst),
	.i_CE (i_CE),
	
	.o_clk (clk_2Hz)
);


endmodule 