-- 20180820-1740
-- Author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;
use work.common_internal_verifla.all;

-----------------------------------------------------

entity top_of_verifla is
	port (clk, rst_l, sys_run: in std_logic;
			data_in: in std_logic_vector(LA_DATA_INPUT_WORDLEN_BITS-1 downto 0);
			-- Transceiver
			uart_XMIT_dataH: out std_logic;
			uart_REC_dataH: in std_logic);
end top_of_verifla;

-----------------------------------------------------

architecture top_of_verifla_arch of top_of_verifla is

	signal mem_port_A_data_in, mem_port_B_dout: std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);
	signal mem_port_A_address, mem_port_B_address: std_logic_vector (LA_MEM_ADDRESS_BITS-1 downto 0) ;
	signal mem_port_A_wen: std_logic;
	signal user_run: std_logic;
	signal sc_run, ack_sc_run, sc_done: std_logic;
	-- Transmitter
	signal  xmit_dataH: std_logic_vector(7 downto 0);
	signal xmit_doneH, xmitH: std_logic;
	-- Receiver
	signal  rec_dataH: std_logic_vector(7 downto 0);
	signal rec_readyH: std_logic;
	-- Baud
	signal baud_clk_posedge: std_logic;

begin
	iUART: entity work.uart_of_verifla(uart_of_verifla_arch)
		port map(clk, rst_l, baud_clk_posedge,
				-- Transmitter
				uart_XMIT_dataH, xmitH, xmit_dataH, xmit_doneH,
				-- Receiver
				uart_REC_dataH, rec_dataH, rec_readyH);
	mi: entity work.memory_of_verifla(memory_of_verifla_arch)
		port map (addra => mem_port_A_address,	addrb => mem_port_B_address,
			clk=>clk,	rst_l=>rst_l,
			dina=>mem_port_A_data_in, 	doutb=>mem_port_B_dout, 
			wea=>mem_port_A_wen);

	ci: entity work.computer_input_of_verifla(computer_input_of_verifla_arch)
		port map (clk, rst_l, rec_dataH, rec_readyH, user_run);
		
	mon: entity work.monitor_of_verifla(monitor_of_verifla_arch)
		port map (clk, rst_l,
			sys_run, user_run, data_in, 
			mem_port_A_address, mem_port_A_data_in, mem_port_A_wen,
			ack_sc_run, sc_done, sc_run);
			
	-- send_capture_of_verifla must use the same reset as the uart.
	sc: entity work.send_capture_of_verifla(send_capture_of_verifla_arch)
		port map (clk, rst_l, baud_clk_posedge,
			sc_run, ack_sc_run, sc_done,
			mem_port_B_address, mem_port_B_dout,
			xmit_doneH, xmitH, xmit_dataH);

end top_of_verifla_arch;

