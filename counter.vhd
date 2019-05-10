library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY counter IS
	PORT(
	set_n	:IN STD_LOGIC;
	enable	:IN STD_LOGIC;
	clk		:IN STD_LOGIC;
	reset_n	:IN STD_LOGIC;
	time_in	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	count 	:OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END counter;

ARCHITECTURE model OF counter IS
	SIGNAL count_int :STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
BEGIN

	PROCESS(clk, reset_n, set_n, enable)
		BEGIN
		IF(reset_n = '1') THEN
			IF(set_n = '1') THEN
				IF(enable = '1') THEN
					IF(rising_edge(clk)) THEN
						IF(count_int < "1111100111") THEN
							count_int <= STD_LOGIC_VECTOR(UNSIGNED(count_int) + 1);
						ELSE
							count_int <= "0000000000";
						END IF;
					END IF;
				END IF;
			ELSE
				count_int <= time_in;
			END IF;
		ELSE
			count_int <= "0000000000";
		END IF;
		
	END PROCESS;
	count <= count_int;
	
END model;