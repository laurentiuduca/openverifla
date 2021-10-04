// SPDX-License-Identifier: GPL-2.0
// Copyright (C) 2020 L-C. Duca


// Data input width and indentical samples bits must be multiple of 8.
parameter LA_DATA_INPUT_WORDLEN_BITS=16;

// Trigger
parameter LA_TRIGGER_VALUE=16'h0204,
		//16'h0200,
		//{LA_DATA_INPUT_WORDLEN_BITS{1'b0}},
	LA_TRIGGER_MASK=16'hffff,
		//16'hff00,
		//{{(LA_DATA_INPUT_WORDLEN_BITS - 10){1'b0}}, 2'b11, 8'h00},
	LA_TRACE_MASK=16'hffff;
		//16'hff00;
		//{LA_DATA_INPUT_WORDLEN_BITS{1'b1}};

parameter LA_IDENTICAL_SAMPLES_BITS=8;
parameter LA_MEM_WORDLEN_BITS=(LA_DATA_INPUT_WORDLEN_BITS+LA_IDENTICAL_SAMPLES_BITS); 
parameter LA_MEM_WORDLEN_OCTETS=((LA_MEM_WORDLEN_BITS+7)/8);
parameter LA_MEM_ADDRESS_BITS=6; 
parameter LA_MEM_FIRST_ADDR=0,
	LA_MEM_LAST_ADDR=((1<<LA_MEM_ADDRESS_BITS)-1);

parameter LA_BT_QUEUE_TAIL_ADDRESS=LA_MEM_LAST_ADDR;
// constraint: (LA_MEM_FIRST_ADDR + 4) <= LA_TRIGGER_MATCH_MEM_ADDR <= (LA_MEM_LAST_ADDR - 4)
parameter LA_TRIGGER_MATCH_MEM_ADDR=8, //((1 << LA_MEM_ADDRESS_BITS) >> 3),
	LA_MEM_LAST_ADDR_BEFORE_TRIGGER=(LA_TRIGGER_MATCH_MEM_ADDR-1);
parameter LA_MAX_SAMPLES_AFTER_TRIGGER_BITS=26,
    LA_MAX_SAMPLES_AFTER_TRIGGER={1'b0, {(LA_MAX_SAMPLES_AFTER_TRIGGER_BITS-1){1'b1}}}; 

// Identical samples
parameter LA_MAX_IDENTICAL_SAMPLES=((1 << LA_IDENTICAL_SAMPLES_BITS) - 2);

/*
Reserved mem words:
 LA_MEM_EMPTY_SLOT which represents an empty and not used memory slot.
*/
parameter LA_MEM_EMPTY_SLOT={LA_MEM_WORDLEN_BITS{1'b0}};

//`define DEBUG_LA
