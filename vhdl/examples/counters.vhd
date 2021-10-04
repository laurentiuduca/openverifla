-- SPDX-License-Identifier: GPL-2.0
-- Copyright (C) 2020, L-C. Duca
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

-----------------------------------------------------

entity counters is
port(	cntb: out std_logic_vector(7 downto 0);
		clk, reset:	in std_logic;
		uart_XMIT_dataH: out std_logic;
		uart_REC_dataH: in std_logic
);
end counters;

-----------------------------------------------------

architecture counters_arch of counters is

    -- define the states of counters_arch model
	signal cnta: std_logic_vector(7 downto 0);
	signal cntb_reg: std_logic_vector(7 downto 0);
	signal verifla_data_in : std_logic_vector(15 downto 0);
begin
 
    -- process: state registers
   state_reg: process(clk, reset)
   begin
		if (reset='1') then
			cnta <= (others => '0');
			cntb_reg <= (others => '0');
		elsif (rising_edge(clk)) then
			if(((cnta and x"01") = x"01") and (cntb_reg < x"f0")) then
				cntb_reg <= std_logic_vector(unsigned(cntb_reg)+x"01");
			end if;
			cnta <= std_logic_vector(unsigned(cnta)+x"01");
		end if;
   end process;
	cntb <= cntb_reg;

	-- openVeriFLA
	verifla_data_in <= cntb_reg & cnta;
		--(15 downto 10 => '0') & kbd_data_line & kbd_clk & kbd_key_reg;
	verifla: entity work.top_of_verifla(top_of_verifla_arch)
		port map (clk=>clk, rst_l=>not(reset), sys_run=>'1',
				data_in=>verifla_data_in,
				-- Transceiver
				uart_XMIT_dataH => uart_XMIT_dataH, 
				uart_REC_dataH => uart_REC_dataH);
	
end counters_arch;
