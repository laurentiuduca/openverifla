-- Author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
-- 20181016-1225
-- LA_TRACE_MASK
-- 20180826-1740
-- split mon_run in sys_run and user_run
-- 20180820-1500
-- first source
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;
use work.common_internal_verifla.all;

-----------------------------------------------------

entity monitor_of_verifla is
	port (clk, rst_l: in std_logic;
		sys_run, user_run: in std_logic;
		data_in: in std_logic_vector(LA_DATA_INPUT_WORDLEN_BITS-1 downto 0);
	mem_port_A_address: out std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0); 
	mem_port_A_data_in: out std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);
	mem_port_A_wen: out std_logic;
	ack_sc_run, sc_done: in std_logic;
	sc_run: out std_logic);
end monitor_of_verifla;

-----------------------------------------------------

architecture monitor_of_verifla_arch of monitor_of_verifla is

	constant LA_MEM_FIRST_ADDR_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0)
		:= std_logic_vector(to_unsigned(LA_MEM_FIRST_ADDR, LA_MEM_ADDRESS_BITS));
	constant LA_MEM_LAST_ADDR_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0) 
		:= std_logic_vector(to_unsigned(LA_MEM_LAST_ADDR, LA_MEM_ADDRESS_BITS));
	constant LA_BT_QUEUE_TAIL_ADDRESS_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0)
		:= LA_MEM_LAST_ADDR_SLV;
	constant LA_TRIGGER_MATCH_MEM_ADDR_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0)
		:= std_logic_vector(to_unsigned(LA_TRIGGER_MATCH_MEM_ADDR, LA_MEM_ADDRESS_BITS));
	constant LA_MEM_LAST_ADDR_BEFORE_TRIGGER_SLV: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0)
		:= std_logic_vector(to_unsigned(LA_MEM_LAST_ADDR_BEFORE_TRIGGER, LA_MEM_ADDRESS_BITS));

	--type state_type is (MON_STATE_IDLE, MON_STATE_DO_MEM_CLEAN, MON_STATE_PREPARE_RUN,
	--MON_STATE_WAIT_TRIGGER_MATCH, MON_STATE_AFTER_TRIGGER, MON_STATE_AFTER_TRIGGER,
	--MON_STATE_CLEAN_REMAINING_MEMORY1,MON_STATE_CLEAN_REMAINING_MEMORY2,MON_STATE_SAVE_BT_QUEUE_TAIL_ADDRESS,
	--MON_STATE_SC_RUN, MON_STATE_WAIT_SC_DONE);
	-- This way, at reset we can set any start state.
	constant MON_STATE_IDLE: integer :=0;
	constant MON_STATE_DO_MEM_CLEAN: integer :=1;
	constant MON_STATE_PREPARE_RUN: integer :=2;
	constant MON_STATE_WAIT_TRIGGER_MATCH: integer :=3;
	constant MON_STATE_AFTER_TRIGGER: integer :=4;
	constant MON_STATE_CLEAN_REMAINING_MEMORY1: integer :=5;
	constant MON_STATE_CLEAN_REMAINING_MEMORY2: integer :=6;
	constant MON_STATE_SAVE_BT_QUEUE_TAIL_ADDRESS: integer :=7;
	constant MON_STATE_SC_RUN: integer :=8;
	constant MON_STATE_WAIT_SC_DONE: integer :=9;

	signal sys_run_reg: std_logic;
	signal sc_run_aux, next_sc_run_aux: std_logic;
	signal mon_state, next_mon_state: integer; -- state_type;
	signal next_mon_samples_after_trigger, mon_samples_after_trigger: 
		std_logic_vector(LA_MAX_SAMPLES_AFTER_TRIGGER_BITS-1 downto 0); 
	signal next_mon_write_address, mon_write_address: 
		std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
	signal next_bt_queue_tail_address, bt_queue_tail_address: std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
	signal next_bt_cycled, bt_cycled: std_logic;
	signal mon_old_data_in, mon_current_data_in:	std_logic_vector(LA_DATA_INPUT_WORDLEN_BITS-1 downto 0);
	signal mon_clones_nr, next_mon_clones_nr: std_logic_vector(LA_IDENTICAL_SAMPLES_BITS-1 downto 0);
	signal one_plus_mon_write_address:std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
	signal oneplus_mon_clones_nr:std_logic_vector(LA_IDENTICAL_SAMPLES_BITS-1 downto 0);
	signal data_in_changed: std_logic;
	signal last_mem_addr_before_trigger: std_logic;
	signal not_maximum_mon_clones_nr: std_logic;

begin

	-- Register the input data
	-- such that mon_current_data_in is constant the full clock period.
	register_input_data: process(clk, rst_l)
	begin
		if (rst_l='0') then
			mon_old_data_in <= (others => '0');
			mon_current_data_in <= (others => '0');
			sys_run_reg <= '0';
		elsif (rising_edge(clk)) then
			mon_old_data_in <= mon_current_data_in;
			mon_current_data_in <= data_in;
			sys_run_reg <= sys_run;
		end if;
	end process;

	-- set new values
	state_reg: process(clk, rst_l)
	begin
		if (rst_l='0') then
			mon_state <= MON_STATE_IDLE;
			sc_run_aux <= '0';
			mon_write_address <= std_logic_vector(to_unsigned(LA_MEM_FIRST_ADDR, LA_MEM_ADDRESS_BITS));
			bt_queue_tail_address <= (others => '0');
			bt_cycled <= '0';
			mon_samples_after_trigger <= (others => '0');
			mon_clones_nr <= ((LA_IDENTICAL_SAMPLES_BITS-1) downto 1 => '0', others => '1');
		elsif (rising_edge(clk)) then
			mon_state <= next_mon_state;
			sc_run_aux <= next_sc_run_aux;
			mon_write_address <= next_mon_write_address;
			bt_queue_tail_address <= next_bt_queue_tail_address;
			bt_cycled <= next_bt_cycled;
			mon_samples_after_trigger <= next_mon_samples_after_trigger;
			mon_clones_nr <= next_mon_clones_nr;
		end if;
	end process;

	-- continuous assignments
	one_plus_mon_write_address <= 
		std_logic_vector(to_unsigned(to_integer(unsigned(mon_write_address)) + 1, LA_MEM_ADDRESS_BITS));
	oneplus_mon_clones_nr <=
		std_logic_vector(to_unsigned(to_integer(unsigned(mon_clones_nr)) + 1, LA_IDENTICAL_SAMPLES_BITS));
	data_in_changed <= '1' when ((mon_current_data_in and LA_TRACE_MASK) /= (mon_old_data_in and LA_TRACE_MASK)) else '0';
	last_mem_addr_before_trigger <= 
		'1' when (to_integer(unsigned(mon_write_address)) = LA_MEM_LAST_ADDR_BEFORE_TRIGGER) else '0';
	not_maximum_mon_clones_nr <= 
		'1' when (to_integer(unsigned(mon_clones_nr)) < LA_MAX_IDENTICAL_SAMPLES) else '0';
	sc_run <= sc_run_aux;

	-- state machine
   comb_logic: process(mon_state, sys_run_reg, user_run, ack_sc_run, sc_done, sc_run_aux,
		mon_write_address, bt_queue_tail_address, bt_cycled, mon_samples_after_trigger,
		mon_current_data_in, mon_old_data_in, mon_clones_nr,
		data_in_changed, oneplus_mon_clones_nr, one_plus_mon_write_address,
		not_maximum_mon_clones_nr, last_mem_addr_before_trigger)
	begin
		-- implicit
		next_mon_state <= mon_state;
		next_sc_run_aux <= sc_run_aux;
		next_mon_write_address <= mon_write_address;
		next_bt_queue_tail_address <= bt_queue_tail_address;
		next_bt_cycled <= bt_cycled;
		next_mon_samples_after_trigger <= mon_samples_after_trigger;
		next_mon_clones_nr <= mon_clones_nr;
		mem_port_A_address <= (others => '0');
		mem_port_A_data_in <= (others => '0');
		mem_port_A_wen <= '0';
		case mon_state is
			when MON_STATE_IDLE =>
				next_bt_cycled <= '0';
				if((sys_run_reg = '1') or (user_run = '1')) then
					if(user_run = '1') then
						next_mon_write_address <= LA_MEM_FIRST_ADDR_SLV;
						next_mon_state <= MON_STATE_DO_MEM_CLEAN;
					else
						-- mon_prepare_run is called from states MON_STATE_IDLE and MON_STATE_PREPARE_RUN
						-- we share the same clock as memory.
						mem_port_A_address <= LA_MEM_FIRST_ADDR_SLV;
						mem_port_A_data_in <= 
							std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
							--{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in};
						mem_port_A_wen <= '1';
						next_mon_write_address <= LA_MEM_FIRST_ADDR_SLV;
						next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
						next_mon_state <= MON_STATE_WAIT_TRIGGER_MATCH;
					end if;
				else
					next_mon_state <= MON_STATE_IDLE;
				end if;
			when MON_STATE_DO_MEM_CLEAN =>
				mem_port_A_address <= mon_write_address;
				mem_port_A_data_in <= LA_MEM_EMPTY_SLOT;
				mem_port_A_wen <= '1';
				if(to_integer(unsigned(mon_write_address)) < LA_MEM_LAST_ADDR) then
					next_mon_write_address <= std_logic_vector(to_unsigned(to_integer(unsigned(mon_write_address)) + 1,
						LA_MEM_ADDRESS_BITS));
					next_mon_state <= MON_STATE_DO_MEM_CLEAN;
				else
					-- at the new posedge clock, will clean memory at its last address 
					next_mon_state <= MON_STATE_PREPARE_RUN;
				end if;
			when MON_STATE_PREPARE_RUN =>
						-- mon_prepare_run is called from states MON_STATE_IDLE and MON_STATE_PREPARE_RUN
						-- we share the same clock as memory.
						mem_port_A_address <= LA_MEM_FIRST_ADDR_SLV;
						mem_port_A_data_in <= 
							std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
							--{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in};
						mem_port_A_wen <= '1';
						next_mon_write_address <= LA_MEM_FIRST_ADDR_SLV;
						next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
						next_mon_state <= MON_STATE_WAIT_TRIGGER_MATCH;
			when MON_STATE_WAIT_TRIGGER_MATCH =>	
				-- circular queue
				if((mon_current_data_in and LA_TRIGGER_MASK) /= (LA_TRIGGER_VALUE and LA_TRIGGER_MASK)) then
					next_mon_state <= MON_STATE_WAIT_TRIGGER_MATCH;
					mem_port_A_wen <= '1';
					if(data_in_changed = '1') then
						if(last_mem_addr_before_trigger = '1') then
							mem_port_A_address <= LA_MEM_FIRST_ADDR_SLV;
						else 
							mem_port_A_address <= one_plus_mon_write_address;
						end if;
					else
						if(not_maximum_mon_clones_nr = '1') then
							mem_port_A_address <= mon_write_address;
						else
							if(last_mem_addr_before_trigger = '1') then
								mem_port_A_address <= LA_MEM_FIRST_ADDR_SLV;
							else 
								mem_port_A_address <= one_plus_mon_write_address;
							end if;
						end if;
					end if;
					if(data_in_changed = '1') then
						mem_port_A_data_in <= 
							std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
											--{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in}
					else
						if(not_maximum_mon_clones_nr = '1') then
							mem_port_A_data_in <= mon_clones_nr & mon_current_data_in;
						else
							mem_port_A_data_in <= 
								std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
											-- {{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in}
						end if;
					end if;
					if(data_in_changed = '1') then
						next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
					else
						if(not_maximum_mon_clones_nr = '1') then
							next_mon_clones_nr <= oneplus_mon_clones_nr; 
						else
							next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
						end if;
					end if;
					if(data_in_changed = '1') then
						if(last_mem_addr_before_trigger = '1') then
							next_mon_write_address <= LA_MEM_FIRST_ADDR_SLV;
						else 
							next_mon_write_address <= one_plus_mon_write_address;
						end if;
					else
						if(not_maximum_mon_clones_nr = '1') then
							next_mon_write_address <= mon_write_address;
						else
							if(last_mem_addr_before_trigger = '1') then
								next_mon_write_address <= LA_MEM_FIRST_ADDR_SLV;
							else 
								next_mon_write_address <= one_plus_mon_write_address;
							end if;
						end if;
					end if;
 					if(bt_cycled /= '1') then
						if(((data_in_changed = '1') and (last_mem_addr_before_trigger = '1')) or
							((data_in_changed = '0') and (not_maximum_mon_clones_nr = '0') and (last_mem_addr_before_trigger = '1'))) then
							next_bt_cycled <= '1';
						end if;
					end if;
				else
					-- trigger matched
					next_mon_state <= MON_STATE_AFTER_TRIGGER;
					mem_port_A_address <= LA_TRIGGER_MATCH_MEM_ADDR_SLV;
					mem_port_A_data_in <= 
						std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
						-- {{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1}, mon_current_data_in};
					mem_port_A_wen <= '1';
					next_mon_write_address <= LA_TRIGGER_MATCH_MEM_ADDR_SLV;
					next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
					next_bt_queue_tail_address <= mon_write_address;
					next_mon_samples_after_trigger <= std_logic_vector(to_unsigned(1, LA_MAX_SAMPLES_AFTER_TRIGGER_BITS));
				end if;		
			when MON_STATE_AFTER_TRIGGER =>	
				if((to_integer(unsigned(mon_samples_after_trigger)) < LA_MAX_SAMPLES_AFTER_TRIGGER) and
					(to_integer(unsigned(mon_write_address)) < LA_MEM_LAST_ADDR)) then
					mem_port_A_wen <= '1';
					if(data_in_changed = '1') then
						mem_port_A_address <= one_plus_mon_write_address;
					else
						if(not_maximum_mon_clones_nr = '1') then
							mem_port_A_address <= mon_write_address;
						else 
							mem_port_A_address <= one_plus_mon_write_address;
						end if;
					end if;
					if(data_in_changed = '1') then
						mem_port_A_data_in <= 
							std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
							--{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in} :
					else
						if(not_maximum_mon_clones_nr = '1') then
							mem_port_A_data_in <= mon_clones_nr & mon_current_data_in;
						else
							mem_port_A_data_in <= 
								std_logic_vector(to_unsigned(0, LA_IDENTICAL_SAMPLES_BITS-1)) & '1' & mon_current_data_in;
							--{{(LA_IDENTICAL_SAMPLES_BITS-1){1'b0}}, 1'b1, mon_current_data_in});
						end if;
					end if;
					if(data_in_changed = '1') then
						next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
					else
						if(not_maximum_mon_clones_nr = '1') then
							next_mon_clones_nr <= oneplus_mon_clones_nr;
						else
							next_mon_clones_nr <= std_logic_vector(to_unsigned(2, LA_IDENTICAL_SAMPLES_BITS));
						end if;
					end if;
					if(data_in_changed = '1') then
						next_mon_write_address <= one_plus_mon_write_address;
					else
						if(not_maximum_mon_clones_nr = '1') then
							next_mon_write_address <= mon_write_address;
						else
							next_mon_write_address <= one_plus_mon_write_address;
						end if;
					end if;
					next_mon_samples_after_trigger <= 
						std_logic_vector(to_unsigned(to_integer(unsigned(mon_samples_after_trigger)+1), 
							LA_MAX_SAMPLES_AFTER_TRIGGER_BITS));
					next_mon_state <= MON_STATE_AFTER_TRIGGER;
				else
					mem_port_A_wen <= '0';
					if (to_integer(unsigned(mon_write_address)) < LA_MEM_LAST_ADDR) then
						next_mon_write_address <= one_plus_mon_write_address;
						next_mon_state <= MON_STATE_CLEAN_REMAINING_MEMORY1;
					else
						next_mon_state <= MON_STATE_CLEAN_REMAINING_MEMORY2;
					end if;
				end if;

			when MON_STATE_CLEAN_REMAINING_MEMORY1 =>
				if(to_integer(unsigned(mon_write_address)) < LA_MEM_LAST_ADDR) then
					mem_port_A_data_in <= LA_MEM_EMPTY_SLOT;
					mem_port_A_wen <= '1';
					mem_port_A_address <= mon_write_address;
					next_mon_write_address <= one_plus_mon_write_address;
				else
					mem_port_A_wen <= '0';
					if(bt_cycled = '1') then
						next_mon_state <= MON_STATE_SAVE_BT_QUEUE_TAIL_ADDRESS;
					else
						next_mon_write_address <= std_logic_vector
							(to_unsigned(to_integer(unsigned(bt_queue_tail_address)) + 1, LA_MEM_ADDRESS_BITS));
						next_mon_state <= MON_STATE_CLEAN_REMAINING_MEMORY2;
					end if;
				end if;

			when MON_STATE_CLEAN_REMAINING_MEMORY2 =>
				if(to_integer(unsigned(mon_write_address)) < LA_TRIGGER_MATCH_MEM_ADDR) then
					mem_port_A_data_in <= LA_MEM_EMPTY_SLOT;
					mem_port_A_wen <= '1';
					mem_port_A_address <= mon_write_address;
					next_mon_write_address <= one_plus_mon_write_address;
				else
					mem_port_A_wen <= '0';
					next_mon_state <= MON_STATE_SAVE_BT_QUEUE_TAIL_ADDRESS;
				end if;

			when MON_STATE_SAVE_BT_QUEUE_TAIL_ADDRESS =>	
				-- Save bt_queue_tail_address
				mem_port_A_address <= LA_BT_QUEUE_TAIL_ADDRESS_SLV;
				mem_port_A_data_in <= 
					std_logic_vector(to_unsigned(0, LA_MEM_WORDLEN_BITS-LA_MEM_ADDRESS_BITS)) & bt_queue_tail_address;
						-- {{(LA_MEM_WORDLEN_BITS-LA_MEM_ADDRESS_BITS){1'b0}}, bt_queue_tail_address};
				mem_port_A_wen <= '1';
				next_mon_state <= MON_STATE_SC_RUN;
			when MON_STATE_SC_RUN =>
				next_mon_state <= MON_STATE_WAIT_SC_DONE;
				next_sc_run_aux <= '1';
			when MON_STATE_WAIT_SC_DONE =>	
				-- sc_run must already be 1.				
				if(ack_sc_run = '1') then
					next_sc_run_aux <= '0';
				end if;
				if((sc_run_aux = '0') and (sc_done = '1')) then
					next_mon_state <= MON_STATE_IDLE;	
				else
					next_mon_state <= MON_STATE_WAIT_SC_DONE;
				end if;
			when others =>
				-- this is forced by the vhdl compiler
		end case;
   end process;

end monitor_of_verifla_arch;
