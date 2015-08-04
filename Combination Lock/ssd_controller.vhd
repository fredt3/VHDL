-- binary to ssd conversion 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ssd_controller IS
PORT (
		NUM					: IN   	STD_LOGIC_VECTOR (3 DOWNTO 0);
		HEX				: OUT 	STD_LOGIC_VECTOR (6 DOWNTO 0)
);
END ssd_controller;

ARCHITECTURE arch OF ssd_controller IS

---------------  ARCHITECTURE BODY   -----------------------------------

BEGIN

PROCESS (NUM )
BEGIN
		CASE NUM IS
			WHEN "0000" =>
				HEX <= "1000000";		-- 0
			WHEN "0001" =>
				HEX <= "1111001";		-- 1
			WHEN "0010" =>
				HEX <= "0100100";		--  2	
			WHEN "0011" =>
				HEX <= "0110000";		--  3	
			WHEN "0100"=>
				HEX <= "0011001";		--  4
			WHEN "0101" =>
				HEX <= "0010010";		--  5
			WHEN "0110" =>
				HEX <= "0000010";		--  6	
			WHEN "0111" =>
				HEX <= "1111000";		--  7
			WHEN "1000" =>
				HEX <= "0000000";		--  8
			WHEN "1001" =>
				HEX <= "0010000";		--  9
			WHEN "1010" =>
				HEX <= "0001000";		--  A
			WHEN "1011" =>
				HEX <= "0000011";		--  b
			WHEN "1100" =>
				HEX <= "1000110";		--  C
			WHEN "1101" =>
				HEX <= "0100001";		--  d	
			WHEN "1110" =>
				HEX <= "0000110";		--  E
			WHEN "1111" =>
				--HEX <= "0001110";		--  F
				HEX <= "1111111";		-- blank
			WHEN OTHERS =>
				HEX <= "1111111";		-- blank
		END CASE;
END PROCESS; 

END arch;
