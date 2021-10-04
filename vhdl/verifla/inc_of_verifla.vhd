-- SPDX-License-Identifier: GPL-2.0
-- Copyright (C) 2020, L-C. Duca

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

---------------------------------------------------------------------------

package inc_of_verifla is

constant CLOCK_FREQUENCY: integer := 50000000;
constant BAUDRATE: integer := 115200;

constant T2_div_T1_div_2: integer := (CLOCK_FREQUENCY / (BAUDRATE * 16 * 2));
-- Assert: BAUD_COUNTER_SIZE >= log2(T2_div_T1_div_2) bits
constant BAUD_COUNTER_SIZE: integer := 15;

-- 1s ... 50000000 T1
-- 1bit ... 16 T2
-- 1s .. 115200 bits
-- =>
-- 1s .. 115200 * 16 T2
--
-- T2 = 5000000 T1 / (115200 * 16) = T1 * 50000000 / (115200 * 16)

end inc_of_verifla;

package body inc_of_verifla is

end inc_of_verifla;
