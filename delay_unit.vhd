library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY delay_unit IS
	PORT(
	max_value :IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	clk 	  :IN STD_LOGIC;
	reset_n	  :IN STD_LOGIC;
	flag	  :OUT STD_LOGIC);
END delay_unit;

ARCHITECTURE model OF delay_unit IS

SIGNAL count 	 :UNSIGNED(15 DOWNTO 0) := "0000000000000000";
SIGNAL flag_int :STD_LOGIC := '0';
	
BEGIN
	

	PROCESS(clk, reset_n, max_value, count)
	
	BEGIN
			IF(reset_n = '0') THEN
				flag_int <= '0';
			ELSE
				IF(rising_edge(clk)) THEN
					IF(count < (UNSIGNED(max_value) - 1)) THEN
						count <= count + 1;
						flag_int <= '0';
					ELSE
						count <= "0000000000000000";
						flag_int <= '1';
					END IF;
				END IF;
			END IF;
	END PROCESS;
	
	flag <= flag_int;

END model;