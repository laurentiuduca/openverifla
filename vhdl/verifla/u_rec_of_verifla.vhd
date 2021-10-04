-- date: 20180816_1740
-- author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

-----------------------------------------------------


entity u_rec_of_verifla is
port(	clk_i, rst_i, baud_clk_posedge:	in std_logic;
		rxd_i: in std_logic; -- serial data in
		rdy_o: out std_logic;
		data_o:out std_logic_vector(7 downto 0)
);
end u_rec_of_verifla;

-----------------------------------------------------

architecture u_rec_of_verifla_arch of u_rec_of_verifla is

	type state_type is (STA_IDLE, STA_CHECK_START_BIT, STA_RECEIVE);
	signal rdy_o_reg: std_logic;
	signal data_o_reg: std_logic_vector(7 downto 0);
	signal rsr: std_logic_vector(7 downto 0); -- receiving shift reg
	signal num_of_rec: std_logic_vector(3 downto 0);
   signal reg_sta: state_type;
	signal count: std_logic_vector(4 downto 0); -- the counter to count the clk in
	--signal count_c: std_logic; -- the carry of count

begin

	rdy_o <= rdy_o_reg;
	data_o <= data_o_reg;
	
   state_reg: process(clk_i, rst_i)
   begin
		if (rst_i='1') then
			data_o_reg     <= x"00";
			rdy_o_reg      <= '0';            
			rsr        <= x"00";
			num_of_rec <= "0000";
			count      <= "00000";
			--count_c    <= '0';
			reg_sta    <= STA_IDLE;
		elsif (rising_edge(clk_i)) then
			if(baud_clk_posedge = '1') then
				case reg_sta is
				when STA_IDLE =>	
					num_of_rec <= x"0";
					count <= "00000";
					if(rxd_i = '0') then
						reg_sta <= STA_CHECK_START_BIT;
					else
						reg_sta <= STA_IDLE;
					end if;
				when STA_CHECK_START_BIT =>
					if(count >= "00111") then
						count <= "00000";
						if(rxd_i = '0') then
							-- has passed 8 clk and rxd_i is still zero,then start bit has been confirmed
							rdy_o_reg <= '0';
							reg_sta <= STA_RECEIVE;
						else
							reg_sta <= STA_IDLE;
						end if;
					else
						reg_sta <= STA_CHECK_START_BIT;
						count   <= std_logic_vector(unsigned(count)+"00001");
					end if;
				when STA_RECEIVE =>
					count <= std_logic_vector(unsigned('0' & count(3 downto 0))+"00001");
					if(count(4) = '1') then
						-- has passed 16 clk after the last bit has been checked,sampling a bit
						if(num_of_rec <= x"7") then
							-- sampling the received bit
							rsr <= rxd_i & rsr(7 downto 1);
							num_of_rec <= std_logic_vector(unsigned(num_of_rec)+"0001");
							reg_sta <= STA_RECEIVE;
						else
							-- sample the stop bit
							data_o_reg <= rsr;
							rdy_o_reg <= '1';
							reg_sta <= STA_IDLE;
						end if;
					end if;
				when others =>
					-- this is forced by the vhdl compiler
				end case;
			end if;
		end if;
	end process;
end u_rec_of_verifla_arch;
