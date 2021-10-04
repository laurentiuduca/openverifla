-- Copyright (C) 2020 Laurentiu-Cristian Duca
-- SPDX-License-Identifier: GPL-2.0
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_counters IS
END test_counters;
 
ARCHITECTURE behavior OF test_counters IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counters
    PORT(
         cntb : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         uart_XMIT_dataH : OUT  std_logic;
         uart_REC_dataH : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal uart_REC_dataH : std_logic := '0';

 	--Outputs
   signal cntb : std_logic_vector(7 downto 0);
   signal uart_XMIT_dataH : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counters PORT MAP (
          cntb => cntb,
          clk => clk,
          reset => reset,
          uart_XMIT_dataH => uart_XMIT_dataH,
          uart_REC_dataH => uart_REC_dataH
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
