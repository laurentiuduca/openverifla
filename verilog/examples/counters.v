// SPDX-License-Identifier: GPL-2.0
// Copyright (C) 2020, L-C. Duca
module counters(cntb,
	clk, reset,
	//top_of_verifla transceiver
	uart_XMIT_dataH, uart_REC_dataH
);


input clk, reset;
output [7:0] cntb;
//top_of_verifla transceiver
input uart_REC_dataH;
output uart_XMIT_dataH;

// Simple counters
reg [7:0] cntb, cnta;
always @(posedge clk or posedge reset)
begin
	if(reset) begin
		cntb = 0;
		cnta = 0;
	end else begin
		if((cnta & 1) && (cntb < 16'hf0))
			cntb = cntb+1;
		cnta = cnta+1;
	end
end

// VeriFLA
top_of_verifla verifla (.clk(clk), .rst_l(!reset), .sys_run(1'b1),
				.data_in({cntb, cnta}),
				// Transceiver
				.uart_XMIT_dataH(uart_XMIT_dataH), .uart_REC_dataH(uart_REC_dataH));

endmodule

// Local Variables:
// verilog-library-directories:(".", "../verifla")
// End:
