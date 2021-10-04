-- 20180820-1740
-- Author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;
use work.common_internal_verifla.all;

-----------------------------------------------------

entity send_capture_of_verifla is
	port (clk, rst_l, baud_clk_posedge: in std_logic;
		sc_run: in std_logic;
		ack_sc_run, sc_done: out std_logic;
		mem_port_B_address: out std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
		mem_port_B_dout: in std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);
		xmit_doneH: in std_logic;
		xmitH: out std_logic;
		xmit_dataH: out std_logic_vector(7 downto 0));
end send_capture_of_verifla;

-----------------------------------------------------

architecture send_capture_of_verifla_arch of send_capture_of_verifla is

	constant LA_MEM_LAST_ADDR_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0) 
		:= std_logic_vector(to_unsigned(LA_MEM_LAST_ADDR, LA_MEM_ADDRESS_BITS));
	constant USERCMD_RESET: std_logic_vector(7 downto 0) :=x"00";
	constant USERCMD_RUN: std_logic_vector(7 downto 0) :=x"01";
	type state_type is (SC_STATE_IDLE, SC_STATE_ACK_SC_RUN, 
		SC_STATE_SET_MEMADDR_TO_READ_FROM, SC_STATE_GET_MEM_OUTPUT_DATA,
		SC_STATE_SEND_OCTET, SC_STATE_WAIT_OCTET_SENT, SC_STATE_WORD_SENT);

	signal sc_state, next_sc_state: state_type;
	signal sc_current_address, next_sc_current_address: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
	signal sc_octet_id, next_sc_octet_id:std_logic_vector(LA_MEM_WORDLEN_OCTETS-1 downto 0);
	signal sc_word_bits, next_sc_word_bits: std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);

begin
	
	-- set up next value
   state_reg: process(clk, rst_l)
   begin
		if (rst_l='0') then
			sc_state<=SC_STATE_IDLE;
			sc_current_address<=(others => '0');
			sc_word_bits<=(others => '0');
			sc_octet_id<= (others => '0');
		elsif (rising_edge(clk)) then
			if (baud_clk_posedge = '1') then
				sc_state <= next_sc_state;
				sc_current_address <= next_sc_current_address;
				sc_word_bits <= next_sc_word_bits;
				sc_octet_id <= next_sc_octet_id;
			end if;
		end if;
	end process;

	-- state machine
   comb_logic: process(sc_state, sc_run, xmit_doneH,
		sc_current_address, sc_word_bits, sc_octet_id, mem_port_B_dout)
	begin
		-- implicit
		next_sc_state<=sc_state;
		ack_sc_run<='0';
		sc_done<='0';
		xmit_dataH<=(others => '0');
		xmitH<='0';
		mem_port_B_address<=sc_current_address;
		next_sc_current_address<=sc_current_address;
		next_sc_word_bits<=sc_word_bits;
		next_sc_octet_id<=sc_octet_id;		
		case sc_state is
			when SC_STATE_IDLE =>
				if(sc_run = '1') then
					next_sc_state <= SC_STATE_ACK_SC_RUN;
					next_sc_current_address <= LA_MEM_LAST_ADDR_SLV;
				else
					next_sc_state <= SC_STATE_IDLE;
				end if;
			when SC_STATE_ACK_SC_RUN =>	
				ack_sc_run <= '1';
				next_sc_state <= SC_STATE_SET_MEMADDR_TO_READ_FROM;			
			when SC_STATE_SET_MEMADDR_TO_READ_FROM =>
				mem_port_B_address <= sc_current_address;
				-- next clock cycle we have memory dout of our read.
				next_sc_state <= SC_STATE_GET_MEM_OUTPUT_DATA;
			when SC_STATE_GET_MEM_OUTPUT_DATA =>
				next_sc_word_bits <= mem_port_B_dout;
				-- LSB first
				next_sc_octet_id <= (others => '0');
				next_sc_state <= SC_STATE_SEND_OCTET;
			when SC_STATE_SEND_OCTET =>
				xmit_dataH <= sc_word_bits(7 downto 0);
				next_sc_word_bits <= x"00" & sc_word_bits(LA_MEM_WORDLEN_BITS-1 downto 8);
					-- shift_right(unsigned(sc_word_bits),8);
				xmitH <= '1';
				next_sc_octet_id <= std_logic_vector(to_unsigned(
					to_integer(unsigned(sc_octet_id))+1, LA_MEM_WORDLEN_OCTETS));
				next_sc_state <= SC_STATE_WAIT_OCTET_SENT;
			when SC_STATE_WAIT_OCTET_SENT =>
				if(xmit_doneH = '1') then
					if(to_integer(unsigned(sc_octet_id)) < LA_MEM_WORDLEN_OCTETS) then
						next_sc_state <= SC_STATE_SEND_OCTET;
					else
						next_sc_state <= SC_STATE_WORD_SENT;
					end if;
				else
					next_sc_state <= SC_STATE_WAIT_OCTET_SENT;
				end if;
			when SC_STATE_WORD_SENT =>
				if(to_integer(unsigned(sc_current_address)) > LA_MEM_FIRST_ADDR) then
					next_sc_current_address <= std_logic_vector(to_unsigned(
						to_integer(unsigned(sc_current_address))-1, LA_MEM_ADDRESS_BITS));
					next_sc_state <= SC_STATE_SET_MEMADDR_TO_READ_FROM;
				else
					-- done sending all captured data
					sc_done <= '1';
					next_sc_state <= SC_STATE_IDLE;
				end if;
			when others =>
				-- this is forced by the vhdl compiler
		end case;
   end process;
		
end send_capture_of_verifla_arch;
