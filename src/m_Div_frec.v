module m_Div_frec 
#(parameter div = 26'd833_333) //max 50 M
(
	input clk,
	input i_Rst,
	input i_CE,
	
	output o_clk
);

	reg o_clk_D;
	reg o_clk_Q;
	

	reg [25:0] r_count_D;
	reg [25:0] r_count_Q;
	
	assign o_clk = o_clk_Q;

	always@(posedge clk)
	begin
		if(~i_Rst)
		begin
			r_count_Q <= 0;
			o_clk_Q <= 0;
		end
		else if(i_CE)
		begin
			r_count_Q <= r_count_D;
			o_clk_Q <= o_clk_D;
		end
		else
		begin
			r_count_Q <= r_count_Q;
			o_clk_Q <= o_clk_Q;
		end
	end
	always@*
	begin
		r_count_D = r_count_Q + 1'd1;
		o_clk_D = 1'd0;
		if(r_count_Q == div)
		begin
			r_count_D = 0;
			o_clk_D = 1'd1;
		end
	end

	//duty cycle 50%
	/*
	always@*
	begin
		r_count_D = r_count_Q + 1'd1;
		o_clk_D = o_clk_Q;
		if(r_count_Q == div)
		begin
			r_count_D = 0;
			o_clk_D = ~o_clk_Q;
		end
	end
*/
endmodule 