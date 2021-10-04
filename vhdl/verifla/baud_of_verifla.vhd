-- 20180816-1450
-- baud rate generator
-- author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;
use work.inc_of_verifla.all;

-----------------------------------------------------

entity baud_of_verifla is
port(	sys_clk, sys_rst_l:in std_logic;
		baud_clk_posedge:	out std_logic
);
end baud_of_verifla;

-----------------------------------------------------

architecture baud_of_verifla_arch of baud_of_verifla is

	-- This were moved to inc_of_verifla.vhd
	--constant CLOCK_FREQUENCY: integer := 50000000;
	--constant BPS: integer := 115200;
	-- 1s ... 50000000 T1
	-- 1bit ... 16 T2
	-- 1s .. 115200 bits
	-- =>
	-- 1s .. 115200 * 16 T2
	--
	-- T2 = 5000000 T1 / (115200 * 16) = T1 * 50000000 / (115200 * 16)
	--constant T2_div_T1_div_2: integer := (CLOCK_FREQUENCY / (BPS * 16 * 2));
	-- COUNTER_SIZE = log2(T2_T1_div_2) bits
	--constant BAUD_COUNTER_SIZE: integer := 15;

   signal counter: std_logic_vector((BAUD_COUNTER_SIZE-1) downto 0);
	signal baud_clk, baud_clk_posedge_reg: std_logic;
	
begin

	baud_clk_posedge <= baud_clk_posedge_reg;

   state_reg: process(sys_clk, sys_rst_l)
   begin
		if (sys_rst_l='0') then
			baud_clk <= '0';
			baud_clk_posedge_reg <= '0';
			counter <= std_logic_vector(to_unsigned(0, BAUD_COUNTER_SIZE)); --x"00000000";
		elsif (rising_edge(sys_clk)) then
			if (counter < std_logic_vector(to_unsigned(T2_div_T1_div_2, BAUD_COUNTER_SIZE))) then
				counter <= counter + std_logic_vector(to_unsigned(1, BAUD_COUNTER_SIZE));
				baud_clk <= baud_clk;
				baud_clk_posedge_reg <= '0';
			else
				if (baud_clk = '0') then
					baud_clk_posedge_reg <= '1';
				end if;
				counter <= std_logic_vector(to_unsigned(0, BAUD_COUNTER_SIZE)); 
				baud_clk <= not(baud_clk);
			end if;
		end if;
   end process;

end baud_of_verifla_arch;
