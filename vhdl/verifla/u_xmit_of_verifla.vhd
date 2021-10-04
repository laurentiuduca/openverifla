-- 20180816-1600
-- author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

-----------------------------------------------------


entity u_xmit_of_verifla is
port(	clk_i, rst_i, baud_clk_posedge:	in std_logic;
		data_i:in std_logic_vector(7 downto 0);
		wen_i: in std_logic;
		txd_o, tre_o: out std_logic
);
end u_xmit_of_verifla;

-----------------------------------------------------

architecture u_xmit_of_verifla_arch of u_xmit_of_verifla is

	type state_type is (STA_IDLE, STA_TRANS, STA_FINISH);
	signal txd_o_reg, tre_o_reg: std_logic;
	signal tsr: std_logic_vector(7 downto 0); -- transmitting shift register
	signal num_of_trans: std_logic_vector(3 downto 0);
   signal reg_sta: state_type;
	signal count: std_logic_vector(4 downto 0); -- the counter to count the clk in
	--signal count_c: std_logic; -- the carry of count

begin

	txd_o <= txd_o_reg;
	tre_o <= tre_o_reg;

   state_reg: process(clk_i, rst_i)
   begin
		if (rst_i='1') then
			tsr          <= x"00";
			txd_o_reg        <= '1';
			tre_o_reg        <= '1';
			num_of_trans <= "0000";
			--count_c      <= '0';
			count        <= "00000";
			reg_sta      <= STA_IDLE;
		elsif (rising_edge(clk_i)) then
			if(baud_clk_posedge = '1') then
				case reg_sta is
				when STA_IDLE =>	
					num_of_trans    <= "0000";
					count           <= "00000";
					--count_c         <= '0';
					if (wen_i = '1') then
						tsr <= data_i;
						tre_o_reg <= '0';
						txd_o_reg <= '0';
						reg_sta <= STA_TRANS;
					else
						reg_sta <= STA_IDLE;
				  end if;
				when STA_TRANS =>
					count <= std_logic_vector(unsigned('0' & count(3 downto 0)) + "00001");
					if(count(4) = '1') then
						if(num_of_trans <= x"8") then
							-- note ,when num_of_trans==8 ,we transmit the stop bit
							tsr <= '1' & tsr(7 downto 1);
							txd_o_reg <= tsr(0);
							num_of_trans <= std_logic_vector(unsigned(num_of_trans) + "0001");
							reg_sta <= STA_TRANS;
						else
							txd_o_reg <= '1';
							tre_o_reg <= '1';
							reg_sta <= STA_IDLE;
						end if;
					end if;
				when others =>
					-- this is forced by the vhdl compiler
				end case;
			end if;
		end if;
   end process;
	
end u_xmit_of_verifla_arch;
