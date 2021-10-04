-- Copyright (C) 2020 L-C. Duca
-- SPDX-License-Identifier: GPL-2.0
-----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;
use work.common_internal_verifla.all;

-----------------------------------------------------

entity memory_of_verifla is port(
  clk, rst_l: in std_logic;
  addra: in std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
  wea: in std_logic; 
  dina: in std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);
  addrb: in std_logic_vector(LA_MEM_ADDRESS_BITS-1 downto 0);
  doutb: out std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0)
);
end memory_of_verifla;
-----------------------------------------------------

architecture memory_of_verifla_arch of memory_of_verifla is

type reg_array is array (0 to LA_MEM_LAST_ADDR) of std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0);

impure function init_mem(n: in integer) return reg_array is
    variable temp_mem : reg_array;
begin
    for i in reg_array'range loop
        temp_mem(i) := LA_MEM_EMPTY_SLOT; --std_logic_vector(to_unsigned(0, LA_MEM_WORDLEN_BITS));
    end loop;
    return temp_mem;
end function;

signal mem: reg_array := init_mem(0);

begin
	-- doutb <= mem(to_integer(unsigned(addrb)));
   -- This works too as a consequence of send_capture_of_verifla architecture.
	p0: process(clk, rst_l)
	begin
		if(rst_l = '0') then
			doutb <= LA_MEM_EMPTY_SLOT;
		elsif(rising_edge(clk)) then
			doutb <= mem(to_integer(unsigned(addrb)));
		end if;
	end process;

	p1: process(clk)
	begin
		if(rising_edge(clk)) then
			if(wea = '1') then
				mem(to_integer(unsigned(addra))) <= dina;
			end if;
		end if;
	end process;
	
end memory_of_verifla_arch;
