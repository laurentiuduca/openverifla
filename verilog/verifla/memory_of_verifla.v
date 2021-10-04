/*
Author: Laurentiu Duca
SPDX-License-Identifier: GPL-2.0
*/

module memory_of_verifla (
  clk, rst_l, //clkb, 
  addra, wea, dina, addrb, doutb
);

`include "common_internal_verifla.v"

input rst_l;
input clk;
//input clkb;
input wea;
input [LA_MEM_ADDRESS_BITS-1:0] addra;
input [LA_MEM_ADDRESS_BITS-1:0] addrb;
output [LA_MEM_WORDLEN_BITS-1:0] doutb;
input [LA_MEM_WORDLEN_BITS-1:0] dina;

reg [LA_MEM_WORDLEN_BITS-1:0] mem[LA_MEM_LAST_ADDR:0];

//assign doutb = mem[addrb];
// This works too as a consequence of send_capture_of_verifla architecture.
reg [LA_MEM_WORDLEN_BITS-1:0] doutb;
always @(posedge clk or negedge rst_l)
if(~rst_l)
	doutb <= LA_MEM_EMPTY_SLOT;
else
	doutb <= mem[addrb];

always @(posedge clk)
begin
		if(wea) begin
			mem[addra] <= dina;
		end
end

initial begin:INIT_SECTION
	integer i;
	for(i=0; i<=LA_MEM_LAST_ADDR; i=i+1)
		mem[i] <= LA_MEM_EMPTY_SLOT;
	//$readmemh("mem2018-2.mif", mem);	
end

endmodule

