-- keypad driver
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY keypad_controller IS
PORT (
		CLOCK_50			: IN   	STD_LOGIC;	
		RESET				: IN   	STD_LOGIC;
		ROW_COL				: IN   	STD_LOGIC_VECTOR (6 DOWNTO 0);
		COL					: OUT  	STD_LOGIC_VECTOR (2 DOWNTO 0);	
		DIGIT				: OUT 	STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END keypad_controller;

ARCHITECTURE arch OF keypad_controller IS

-- state type
TYPE state IS (first, col_1_WR, col_1_RD, col_2_WR, col_2_RD, col_3_WR, col_3_RD  );
SIGNAL pr_state, nx_state: state;
signal global_keypad_values	: STD_LOGIC_VECTOR (6 DOWNTO 0) ;
--CONSTANT count_max: 	INTEGER := 50000;	-- 50000 = 1 ms for 50MHz clock
CONSTANT count_max: 	INTEGER := 250000;	-- 250000 = 5 ms for 50MHz clock

---------------  ARCHITECTURE BODY   -----------------------------------

BEGIN

------------------------- process for lower section of FSM ----------------------------------
lower_section:
PROCESS (CLOCK_50, RESET)
VARIABLE count	: INTEGER RANGE 0 TO 50000000;
BEGIN
	IF (RESET = '0') THEN
		pr_state <= first;
		count 	:= 0;
	ELSIF (CLOCK_50'EVENT AND CLOCK_50 = '1') THEN 	-- rising edge
		count := count + 1;
		IF (count = count_max) THEN
			pr_state <= nx_state;
			count := 0;
		END IF;
	END IF;
END PROCESS lower_section;

------------------------- process for upper section of FSM ----------------------------------  
upper_section:
PROCESS (pr_state )
BEGIN
	CASE pr_state IS
	
		WHEN first =>
			nx_state <= col_1_WR;
		WHEN col_1_WR =>
			nx_state <= col_1_RD;
			
		WHEN col_1_RD =>
			nx_state <= col_2_WR;	
			 	
		WHEN col_2_WR =>
			nx_state <= col_2_RD;
			 
		WHEN col_2_RD =>
			nx_state <= col_3_WR;
		
		WHEN col_3_WR =>
			nx_state <= col_3_RD;	
		
		WHEN col_3_RD =>
			nx_state <= first;
		 	
		WHEN OTHERS =>
			nx_state <= first;
			
	END CASE;
	
END PROCESS upper_section ;

----------------------- process for output registers -----------------------------------
-- this is added to reduce glitches --> delay 1 cycle
output_section:
PROCESS (CLOCK_50 )
VARIABLE keypad_values		: STD_LOGIC_VECTOR (6 DOWNTO 0) ;
VARIABLE keypad_values_2	: STD_LOGIC_VECTOR (6 DOWNTO 0) ;
BEGIN
	IF (CLOCK_50'EVENT AND CLOCK_50 = '1') THEN -- rising edge	
	
		CASE pr_state IS
			WHEN first =>
				COL 	<= "111";	
				keypad_values := "0000000";
			WHEN col_1_WR =>
				COL 	<= "110";	
			WHEN col_1_RD =>
				COL 	<= "110";	 
				IF (ROW_COL(3 DOWNTO 0) /= "1111" ) THEN
					keypad_values := ROW_COL;
				END IF;
			WHEN col_2_WR =>
				COL 	<= "101";
			WHEN col_2_RD =>
				COL 	<= "101";
				IF (ROW_COL(3 DOWNTO 0) /= "1111" ) THEN
					keypad_values := ROW_COL;
				END IF; 
			WHEN col_3_WR =>
				COL 	<= "011";	
			WHEN col_3_RD =>
				COL 	<= "011";
				IF (ROW_COL(3 DOWNTO 0) /= "1111" ) THEN
					keypad_values := ROW_COL;
				END IF; 
				keypad_values_2 := keypad_values;
			WHEN OTHERS =>
				COL 	<= "111";		
		END CASE;	
	
		CASE keypad_values_2 IS
			WHEN "1010111" =>
				DIGIT <= "0000";		-- Key 0
			WHEN "1101110" =>
				DIGIT <= "0001";		-- Key 1
			WHEN "1011110" =>
				DIGIT <= "0010";		-- Key 2	
			WHEN "0111110" =>
				DIGIT <= "0011";		-- Key 3	
			WHEN "1101101"=>
				DIGIT <= "0100";		-- Key 4
			WHEN "1011101" =>
				DIGIT <= "0101";		-- Key 5
			WHEN "0111101" =>
				DIGIT <= "0110";		-- Key 6	
			WHEN "1101011" =>
				DIGIT <= "0111";		-- Key 7
			WHEN "1011011" =>
				DIGIT <= "1000";		-- Key 8
			WHEN "0111011" =>
				DIGIT <= "1001";		-- Key 9
			WHEN "1100111" =>
				DIGIT <= "1010";		-- Key *	 
			WHEN "0110111" =>
				DIGIT <= "1011";		-- Key #
			WHEN OTHERS =>
				DIGIT <= "1111";		-- error
		END CASE;
		
	END IF;
END PROCESS output_section;
END arch;
