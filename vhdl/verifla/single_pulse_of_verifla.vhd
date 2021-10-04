-----------------------------------------------------
-- single pulse from a multi-periods-contiguous pulse
-- date: 20180820-1700
-- author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

-----------------------------------------------------

entity single_pulse_of_verifla is
port(	clk, rst_l: in std_logic;
		ub: in std_logic;
		ubsing: out std_logic
);
end single_pulse_of_verifla;

-----------------------------------------------------

architecture single_pulse_of_verifla_arch of single_pulse_of_verifla is

   signal next_state, state: std_logic;
	signal ubsing_reg, next_ubsing_reg: std_logic;

begin
	ubsing <= ubsing_reg;
  
   state_reg: process(clk, rst_l)
   begin
		if (rst_l='0') then
			state <= '0';
			ubsing_reg <= '0';
		elsif (rising_edge(clk)) then
				state <= next_state;
				ubsing_reg <= next_ubsing_reg;
		end if;
   end process;

   comb_logic: process(state, ub)
	begin
		next_state <= state;
		next_ubsing_reg <= '0';
		case state is
			when '0' =>
				if (ub = '1') then
					 next_state <= '1';
					 next_ubsing_reg <= '1';
				end if;
			when '1' =>	
				if (ub = '0') then
					next_state <= '0';
				end if;
			when others =>
				-- this is forced by the vhdl compiler
				--next_state <= '0';
				--next_ubsing_reg <= '0';
		end case;
   end process;

end single_pulse_of_verifla_arch;

-----------------------------------------------------
