// SPDX-License-Identifier: GPL-2.0
// Copyright (C) 2020, L-C. Duca

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:19:39 01/21/2019
// Design Name:   counters
// Module Name:   /home/laur/lucru/cn/openverifla/verilog_counter_verifla/test_counters.v
// Project Name:  verilog_xilinx_keyboard
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counters
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_counters;

	// Inputs
	reg clk;
	reg reset;
	reg uart_REC_dataH;

	// Outputs
	wire [7:0] cntb;
	wire uart_XMIT_dataH;

	// Instantiate the Unit Under Test (UUT)
	counters uut (
		.cntb(cntb), 
		.clk(clk), 
		.reset(reset), 
		.uart_XMIT_dataH(uart_XMIT_dataH), 
		.uart_REC_dataH(uart_REC_dataH)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		uart_REC_dataH = 1;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;
		// Add stimulus here

	end
      
	always begin
		clk = 0; #5;
		clk = 1; #5;
	end
endmodule

