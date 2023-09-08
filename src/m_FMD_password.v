module m_FMD_password
(
	input clk,
	input i_Rst,
	input i_CE,
	input i_set_data,
	input [3:0] iv_data,
	
	output [7:0] o_acknowledge
);

localparam [2:0] 		S0 = 3'd0,  // Key = 3
				S1 = 3'd1,  // Key = 0
				S2 = 3'd2,  // Key = 4
				S3 = 3'd3,  // Key = 4
				S4 = 3'd4,  // Key = 2
				S5 = 3'd5,  // Key = 3
				S6 = 3'd6,  // Key = 8
				S7 = 3'd7;
									  // Numero de cuenta 3044238
reg [2:0] r_Current_State;
reg [2:0] r_Next_State;
									  
reg [7:0] or_acknowledge_Q;
reg [7:0] or_acknowledge_D;


assign o_acknowledge = or_acknowledge_Q;

always@(posedge clk)
begin
	if(~i_Rst)
	begin
		 r_Current_State <= S0;
		or_acknowledge_Q <= 0;
	end
	else if(i_CE)
	begin
		r_Current_State <= r_Next_State;
		or_acknowledge_Q <= or_acknowledge_D;
	end 
	else
	begin
		r_Current_State <= r_Current_State;
		or_acknowledge_Q <= or_acknowledge_Q;
	end
end

always@*
begin
	r_Next_State = r_Current_State;
	or_acknowledge_D = or_acknowledge_Q;
	if(~i_set_data)
	begin
		case(r_Current_State)
			////////////// S0 //////////////
			S0:
			begin
				or_acknowledge_D = 0; //Reset acknowledge signal
				if(iv_data == 4'd3)
				begin
					r_Next_State = S1;
					or_acknowledge_D[0] = 1;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			////////////// S1 //////////////
			S1:
			begin
				if(iv_data == 4'd0)
				begin
					r_Next_State = S2;
					or_acknowledge_D[1] = 1;
				end
				else
				begin
					r_Next_State = S0;
					or_acknowledge_D = 0;
				end
			end
			////////////// S2 //////////////
			S2:
			begin
				if(iv_data == 4'd4)
				begin
					or_acknowledge_D[2] = 1;
					r_Next_State = S3;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			////////////// S3 //////////////
			S3:
			begin
				if(iv_data == 4'd4)
				begin
					or_acknowledge_D[3] = 1;
					r_Next_State = S4;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			////////////// S4 //////////////
			S4:
			begin
				if(iv_data == 4'd2)
				begin
					or_acknowledge_D[4] = 1;
					r_Next_State = S5;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			////////////// S5 //////////////
			S5:
			begin
				if(iv_data == 4'd3)
				begin
					or_acknowledge_D[5] = 1;
					r_Next_State = S6;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			////////////// S6 //////////////
			S6:
			begin
				if(iv_data == 4'd8)
				begin
					or_acknowledge_D[6] = 1;
					r_Next_State = S7;
				end
				else
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
			S7:
			begin
				begin
					or_acknowledge_D[7] = 1;
					r_Next_State = S7;
				end
			end
			default:
			begin
				begin
					or_acknowledge_D = 0;
					r_Next_State = S0;
				end
			end
		endcase
	end
end

endmodule 