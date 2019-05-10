library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY binary2ssd IS
	PORT(
	In_num		:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	HEX0, HEX1, HEX2, HEX3 :OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END binary2ssd;

ARCHITECTURE model OF binary2ssd IS
	CONSTANT zero 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "1000000";
	CONSTANT one			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "1111001";
	CONSTANT two 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0100100";
	CONSTANT three 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0110000";
	CONSTANT four 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0011001";
	CONSTANT five 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0010010";
	CONSTANT six 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0000010";
	CONSTANT seven 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "1111000";
	CONSTANT eight 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0000000";
	CONSTANT nine 			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0010000";
	CONSTANT dash			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "0111111";
	CONSTANT blank			: STD_LOGIC_VECTOR (6 DOWNTO 0) := "1111111";
	
	SIGNAL In_num_signal	: UNSIGNED (9 DOWNTO 0);
	SIGNAL HEX3_signal		: STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL HEX2_signal		: STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL HEX1_signal		: STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL HEX0_signal		: STD_LOGIC_VECTOR (6 DOWNTO 0);
	
	SIGNAL ones_dig			: UNSIGNED (3 DOWNTO 0);
	SIGNAL tens_dig			: UNSIGNED (3 DOWNTO 0);
	SIGNAL huns_dig			: UNSIGNED (3 DOWNTO 0);
	SIGNAL thou_dig			: UNSIGNED (3 DOWNTO 0);
	
	BEGIN
		
			In_num_signal <= UNSIGNED(In_num);
			
			thou_dig <= resize((In_num_signal / 1000),thou_dig'LENGTH);
			huns_dig <= resize(((In_num_signal rem 1000) / 100),huns_dig'LENGTH);
			tens_dig <= resize((((In_num_signal rem 1000) rem 100) / 10),tens_dig'LENGTH);
			ones_dig <= resize(((In_num_signal rem 1000) rem 100) rem 10,ones_dig'LENGTH);
			
			hex3_display: PROCESS(thou_dig)
			BEGIN
				CASE thou_dig IS
					WHEN "0000" => HEX3_signal <= zero;
					WHEN "0001" => HEX3_signal <= one;
					WHEN "0010" => HEX3_signal <= two;
					WHEN "0011" => HEX3_signal <= three;
					WHEN "0100" => HEX3_signal <= four;
					WHEN "0101" => HEX3_signal <= five;
					WHEN "0110" => HEX3_signal <= six;
					WHEN "0111" => HEX3_signal <= seven;
					WHEN "1000" => HEX3_signal <= eight;
					WHEN "1001" => HEX3_signal <= nine;
					WHEN OTHERS => HEX3_signal <= blank;
				END CASE;
			END PROCESS;
			
			hex2_display: PROCESS(huns_dig)
			BEGIN
				CASE huns_dig IS
					WHEN "0000" => HEX2_signal <= zero;
					WHEN "0001" => HEX2_signal <= one;
					WHEN "0010" => HEX2_signal <= two;
					WHEN "0011" => HEX2_signal <= three;
					WHEN "0100" => HEX2_signal <= four;
					WHEN "0101" => HEX2_signal <= five;
					WHEN "0110" => HEX2_signal <= six;
					WHEN "0111" => HEX2_signal <= seven;
					WHEN "1000" => HEX2_signal <= eight;
					WHEN "1001" => HEX2_signal <= nine;
					WHEN OTHERS => HEX2_signal <= blank;
				END CASE;
			END PROCESS;
			
			hex1_display: PROCESS(tens_dig)
			BEGIN
				CASE tens_dig IS
					WHEN "0000" => HEX1_signal <= zero;
					WHEN "0001" => HEX1_signal <= one;
					WHEN "0010" => HEX1_signal <= two;
					WHEN "0011" => HEX1_signal <= three;
					WHEN "0100" => HEX1_signal <= four;
					WHEN "0101" => HEX1_signal <= five;
					WHEN "0110" => HEX1_signal <= six;
					WHEN "0111" => HEX1_signal <= seven;
					WHEN "1000" => HEX1_signal <= eight;
					WHEN "1001" => HEX1_signal <= nine;
					WHEN OTHERS => HEX1_signal <= blank;
				END CASE;
			END PROCESS;
			
			hex0_display: PROCESS(ones_dig)
			BEGIN
				CASE ones_dig IS
					WHEN "0000" => HEX0_signal <= zero;
					WHEN "0001" => HEX0_signal <= one;
					WHEN "0010" => HEX0_signal <= two;
					WHEN "0011" => HEX0_signal <= three;
					WHEN "0100" => HEX0_signal <= four;
					WHEN "0101" => HEX0_signal <= five;
					WHEN "0110" => HEX0_signal <= six;
					WHEN "0111" => HEX0_signal <= seven;
					WHEN "1000" => HEX0_signal <= eight;
					WHEN "1001" => HEX0_signal <= nine;
					WHEN OTHERS => HEX0_signal <= blank;
				END CASE;
			END PROCESS;
	
			
			HEX3 <= HEX3_signal;
			HEX2 <= HEX2_signal;
			HEX1 <= HEX1_signal;
			HEX0 <= HEX0_signal;

END model;