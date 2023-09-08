module tt_um_BounceFSM_RSYO3000 (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches for clk_selector and pattern_sel
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 LEDs
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled, not used circuit can be turned off when pattern_sel = 0
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
assign uio_out = 0;
assign uio_oe = 0;
    
BounceFSM M0
(
	.clk(clk),
	.i_Rst(rst_n),
	.i_CE(ui_in[0]), // 1 bit
	.i_set_data(ui_in[1]), // 1 bit
	.iv_data(ui_in[7:4]), // 4 bit
	.o_acknowledge(uo_out) // 8 bit, 7 for checking, 8 for unlock
);

endmodule
