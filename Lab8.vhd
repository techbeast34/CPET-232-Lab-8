--Satyendra Emani
--Lab 8: Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY Lab8 IS
	PORT(
	clk		:IN STD_LOGIC; --Clock
	reset_n	:IN STD_LOGIC; --Reset (Active Low)
	set_n	:IN STD_LOGIC; --TIme Set (Active Low)
	S 		:IN STD_LOGIC; --0: sim mode, 1: FPGA mode
	Pre_time	:IN STD_LOGIC_VECTOR(9 DOWNTO 0); --Time Set Input
	HEX0, HEX1, HEX2, HEX3 :OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); --SSD Output
END Lab8;

ARCHITECTURE model OF Lab8 IS
	COMPONENT delay_unit
		PORT(
		max_value :IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk 	  :IN STD_LOGIC;
		reset_n	  :IN STD_LOGIC;
		flag	  :OUT STD_LOGIC);
	END COMPONENT; --Underclock component
	
	COMPONENT counter
		PORT(
		set_n	:IN STD_LOGIC;
		enable	:IN STD_LOGIC;
		clk		:IN STD_LOGIC;
		reset_n	:IN STD_LOGIC;
		time_in	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		count 	:OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
	END COMPONENT; --Counter component
	
	COMPONENT binary2ssd
		PORT(
		In_num		:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3 :OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT; --SSD driver
	
	SIGNAL max_value_int :STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL flag_int		 :STD_LOGIC;
	SIGNAL count_int     :STD_LOGIC_VECTOR(9 DOWNTO 0);
	
BEGIN
	PROCESS(S)
	BEGIN
		CASE S IS
			WHEN '0' => max_value_int <= "0000000000000101";
			WHEN '1' => max_value_int <= "1100001101010000";
			--1ms is 1100001101010000, but this ^^ is changed so we can see the numbers--	
			WHEN OTHERS => max_value_int <= "0000000000000000";
		END CASE;
	END PROCESS; --Mux for selecting the delay 
	
	U1: delay_unit PORT MAP(max_value_int, clk, reset_n, flag_int);
	U2: counter PORT MAP(set_n, flag_int, clk, reset_n, Pre_time, count_int);
	U3: binary2ssd PORT MAP(count_int, HEX0, HEX1, HEX2, HEX3);
	
END model;




