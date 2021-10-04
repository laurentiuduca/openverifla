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

entity computer_input_of_verifla is
	port (clk, rst_l: in std_logic;
		rec_dataH: in std_logic_vector(7 downto 0);
		rec_readyH: in std_logic;
		user_run: out std_logic);
end computer_input_of_verifla;

-----------------------------------------------------

architecture computer_input_of_verifla_arch of computer_input_of_verifla is

--constant USERCMD_RESET: std_logic_vector(7 downto 0) :=x"00";
constant USERCMD_RUN: std_logic_vector(7 downto 0) :=x"01";
type state_type is (CI_STATE_IDLE, CI_STATE_START_OF_NEW_CMD);
signal ci_state, next_ci_state: state_type;
signal ci_indata, next_ci_indata: std_logic_vector(7 downto 0);
signal ci_new_octet_received:std_logic;
signal next_user_run: std_logic;

begin

	-- T(clk)<<T(uart_clk)
	sp1: entity work.single_pulse_of_verifla(single_pulse_of_verifla_arch)
		port map (clk=>clk, rst_l=>rst_l, ub=>rec_readyH, ubsing=>ci_new_octet_received);
	
	-- set up next value
   state_reg: process(clk, rst_l)
   begin
		if (rst_l='0') then
			ci_state<=CI_STATE_IDLE;
			ci_indata<=x"00";
			user_run <= '0';
		elsif (rising_edge(clk)) then
			ci_state<=next_ci_state;
			ci_indata<=next_ci_indata;
			user_run <= next_user_run;
		end if;
	end process;

	-- state machine
   comb_logic: process(ci_new_octet_received, rec_dataH, ci_state, ci_indata)
	begin
		-- implicit
		next_ci_state <= ci_state;
		next_ci_indata <= x"00";
		next_user_run <= '0';
		case ci_state is
			when CI_STATE_IDLE =>
				if(ci_new_octet_received = '1') then
					next_ci_indata <= rec_dataH;
					next_ci_state <= CI_STATE_START_OF_NEW_CMD;
				else
					next_ci_state<=CI_STATE_IDLE;
				end if;
			when CI_STATE_START_OF_NEW_CMD =>
				next_ci_state<=CI_STATE_IDLE;
				if (ci_indata = USERCMD_RUN) then
					next_user_run<='1';
				end if;
			when others =>
				-- this is forced by the vhdl compiler
		end case;
   end process;

end computer_input_of_verifla_arch;
