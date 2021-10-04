/*
file: top_of_verifla.v
SPDX-License-Identifier: GPL-2.0
Revision history
revision date: 2007/Sep/03; author: Laurentiu DUCA
- sys_run: an internal possible run command
- combined_reset_low which allows the user to reset the monitor

revision date: 2007/Jul/4; author: Laurentiu DUCA
- v01
*/


module top_of_verifla(clk, rst_l, sys_run, data_in,
				// Transceiver
				uart_XMIT_dataH, uart_REC_dataH
				);
				
`include "common_internal_verifla.v"

input clk, rst_l, sys_run;
input [LA_DATA_INPUT_WORDLEN_BITS-1:0] data_in;
output uart_XMIT_dataH;
input uart_REC_dataH;

// App. specific.
wire [LA_MEM_WORDLEN_BITS-1:0] mem_port_A_data_in, mem_port_B_dout;
wire [LA_MEM_ADDRESS_BITS-1:0] mem_port_A_address, mem_port_B_address;
wire mem_port_A_wen;
wire user_run;
wire sc_run, ack_sc_run, sc_done;

// Transceiver
wire [7:0] xmit_dataH;
wire xmit_doneH;
wire xmitH;
// Receiver
wire [7:0] rec_dataH;
wire rec_readyH;
// Baud
wire baud_clk_posedge;

uart_of_verifla iUART (clk, rst_l, baud_clk_posedge,
				// Transmitter
				uart_XMIT_dataH, xmitH, xmit_dataH, xmit_doneH,
				// Receiver
				uart_REC_dataH, rec_dataH, rec_readyH);

memory_of_verifla mi (
	.addra(mem_port_A_address),	.addrb(mem_port_B_address),
	.clk(clk),	.rst_l(rst_l),
	.dina(mem_port_A_data_in), 	.doutb(mem_port_B_dout), 
	.wea(mem_port_A_wen));

computer_input_of_verifla ci (clk, rst_l, 
	rec_dataH, rec_readyH, user_run);
	
monitor_of_verifla mon (clk, rst_l,
		sys_run, user_run, data_in, 
		mem_port_A_address, mem_port_A_data_in, mem_port_A_wen,
		ack_sc_run, sc_done, sc_run);
// send_capture_of_verifla must use the same reset as the uart.
send_capture_of_verifla sc (clk, rst_l, baud_clk_posedge,
	sc_run, ack_sc_run, sc_done,
	mem_port_B_address, mem_port_B_dout,
	xmit_doneH, xmitH, xmit_dataH);

endmodule

