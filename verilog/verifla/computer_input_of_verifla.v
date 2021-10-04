/*
file: computer_input_of_verifla.v
SPDX-License-Identifier: GPL-2.0

Revision history
- 20180827-1700
allow only USERCMD_RUN.
revision date: 2007/Sep/03; author: Laurentiu DUCA
- USERCMD_RESET

revision date: 2007/Jul/4; author: Laurentiu DUCA
- v01
*/


module computer_input_of_verifla (clk, rst_l, 
	rec_dataH, rec_readyH, user_run);
// user commands
parameter USERCMD_RUN = 8'h01;
// CI_states
parameter	CI_STATES_BITS=4,
	CI_STATE_IDLE=0,
	CI_STATE_START_OF_NEW_CMD=1;

// input
input clk, rst_l;
input rec_readyH;
input [7:0] rec_dataH;
// output
output user_run;
reg user_run;
// locals
reg [CI_STATES_BITS-1:0] ci_state, next_ci_state;
reg [7:0] ci_indata, next_ci_indata;
wire ci_new_octet_received;

// T(clk)<<T(uart_clk)
single_pulse_of_verifla sp1(.clk(clk), .rst_l(rst_l), .ub(rec_readyH), .ubsing(ci_new_octet_received));
	
// set up next value
always @(posedge clk or negedge rst_l)
begin
	if(~rst_l)
	begin
		ci_state=CI_STATE_IDLE;
		ci_indata=0;
	end
	else
	begin
		ci_state=next_ci_state;
		ci_indata=next_ci_indata;
	end
end

// state machine
always @(ci_new_octet_received or rec_dataH or ci_state or ci_indata)
begin
	// implicit
	next_ci_state=ci_state;
	next_ci_indata=0;
	user_run=0;
	
	// state dependent
	case(ci_state)
	CI_STATE_IDLE:
	begin
		if(ci_new_octet_received)
		begin
			next_ci_indata=rec_dataH;
			next_ci_state=CI_STATE_START_OF_NEW_CMD;
		end
		else
			next_ci_state=CI_STATE_IDLE;
	end
	
	CI_STATE_START_OF_NEW_CMD:
	begin
		next_ci_state=CI_STATE_IDLE;
		if(ci_indata == USERCMD_RUN)
			user_run=1;
	end	
	
	default: // should never get here
	begin
		next_ci_state=CI_STATE_IDLE;
	end
	endcase
end

endmodule
