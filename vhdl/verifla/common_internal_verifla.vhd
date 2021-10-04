-- date: 20180821-1530
-- author: Laurentiu Duca
-- SPDX-License-Identifier: GPL-2.0
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

---------------------------------------------------------------------------

package common_internal_verifla is

-- Data input width and indentical samples bits must be multiple of 8.
constant LA_DATA_INPUT_WORDLEN_BITS: integer :=16;

-- Trigger
constant LA_TRIGGER_VALUE: std_logic_vector((LA_DATA_INPUT_WORDLEN_BITS-1) downto 0)
	:=x"0204";
constant LA_TRIGGER_MASK: std_logic_vector((LA_DATA_INPUT_WORDLEN_BITS-1) downto 0)
	:=x"ffff";
constant LA_TRACE_MASK: std_logic_vector((LA_DATA_INPUT_WORDLEN_BITS-1) downto 0)
	:=(others => '1');

constant LA_IDENTICAL_SAMPLES_BITS: integer :=8;
constant LA_MEM_WORDLEN_BITS: integer :=(LA_DATA_INPUT_WORDLEN_BITS+LA_IDENTICAL_SAMPLES_BITS); 
constant LA_MEM_WORDLEN_OCTETS: integer :=((LA_MEM_WORDLEN_BITS+7)/8);
constant LA_MEM_ADDRESS_BITS: integer :=6;
constant LA_MEM_FIRST_ADDR: integer := 0;
constant LA_MEM_LAST_ADDR: integer := 2 ** LA_MEM_ADDRESS_BITS - 1;

constant LA_BT_QUEUE_TAIL_ADDRESS: integer :=LA_MEM_LAST_ADDR;
-- constraint: (LA_MEM_FIRST_ADDR + 4) <= LA_TRIGGER_MATCH_MEM_ADDR <= (LA_MEM_LAST_ADDR - 4)
constant LA_TRIGGER_MATCH_MEM_ADDR: integer := 8; --2 ** (LA_MEM_ADDRESS_BITS - 3);
constant LA_MEM_LAST_ADDR_BEFORE_TRIGGER: integer := LA_TRIGGER_MATCH_MEM_ADDR - 1;
constant LA_MAX_SAMPLES_AFTER_TRIGGER_BITS: integer :=26;
constant LA_MAX_SAMPLES_AFTER_TRIGGER: integer := 2 ** (LA_MAX_SAMPLES_AFTER_TRIGGER_BITS-1) - 1;

-- Identical samples
constant LA_MAX_IDENTICAL_SAMPLES: integer := 2 ** LA_IDENTICAL_SAMPLES_BITS - 2;

--Reserved mem words
-- LA_MEM_EMPTY_SLOT which represents an empty and not used memory slot.
constant LA_MEM_EMPTY_SLOT: std_logic_vector(LA_MEM_WORDLEN_BITS-1 downto 0)
	:= (others => '0');

end common_internal_verifla;
