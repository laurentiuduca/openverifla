// SPDX-License-Identifier: GPL-2.0
// Copyright (C) 2020, L-C. Duca

parameter CLOCK_FREQUENCY = 50000000;
// If CLOCK_FREQUENCY < 50 MHz then BAUDRATE must be < 115200 bps (for example 9600).
parameter BAUDRATE = 115200;

parameter T2_div_T1_div_2 = CLOCK_FREQUENCY / (BAUDRATE * 16 * 2);
// Assert: BAUD_COUNTER_SIZE >= log2(T2_div_T1_div_2) bits
parameter BAUD_COUNTER_SIZE = 15;
//`define DEBUG
/*
1s ... 50000000 T1
1bit ... 16 T2
1s .. 115200 bits
=>
1s .. 115200 * 16 T2

T2 = 5000000 T1 / (115200 * 16) = T1 * 50000000 / (115200 * 16)
*/
