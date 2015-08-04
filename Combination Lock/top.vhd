LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY top IS
PORT (
		CLOCK_50				: IN   	STD_LOGIC;	
		KEY					: IN   	STD_LOGIC_VECTOR (3 DOWNTO 0);
		GPIO_1				: IN   	STD_LOGIC_VECTOR (6 DOWNTO 0);
		GPIO_0				: OUT  	STD_LOGIC_VECTOR (2 DOWNTO 0);	
		HEX0					: OUT  	STD_LOGIC_VECTOR (6 DOWNTO 0);
		LED 					: OUT		STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END top;

ARCHITECTURE arch OF top IS

---------------  COMPONENT DECLARATION -----------------------------------
COMPONENT keypad_controller IS
PORT (
		CLOCK_50			: IN   	STD_LOGIC;	
		RESET				: IN   	STD_LOGIC;
		ROW_COL			: IN   	STD_LOGIC_VECTOR (6 DOWNTO 0);
		COL				: OUT  	STD_LOGIC_VECTOR (2 DOWNTO 0);	
		DIGIT				: OUT 	STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END COMPONENT;

COMPONENT ssd_controller IS
PORT (
		NUM				: IN   	STD_LOGIC_VECTOR (3 DOWNTO 0);
		HEX				: OUT 	STD_LOGIC_VECTOR (6 DOWNTO 0)
);
END COMPONENT;

COMPONENT lockbrain IS
PORT (
		KEYPAD	: IN STD_LOGIC_VECTOR (3 DOWNTO 0); 
		CLOCK		: IN STD_LOGIC;
		ENTER		: IN STD_LOGIC;
		RESET		: IN STD_LOGIC;

		LED		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
END COMPONENT;

---------------  SIGNAL DECLARATION -----------------------------------
SIGNAL KEYPAD_NUM			: STD_LOGIC_VECTOR (3 DOWNTO 0); -- 0 to 9
---------------  ARCHITECTURE BODY   -----------------------------------

BEGIN

-----------------  COMPONENT INSTANTIATION ------------------------------
-- Detecting input from 12-button keypad
-- look at schematic for specific connections
-- this module scans for new input every 35 ms (7 states * 5ms)
Keypad_detect: keypad_controller
	PORT MAP(
				CLOCK_50 	=> CLOCK_50,
				RESET			=> KEY(0),
				ROW_COL		=> GPIO_1,		-- input from keypad (7 bits for 4 rows and 3 cols)
				COL			=> GPIO_0, 		-- output to keypad (3 bits for 3 cols)
				DIGIT			=> KEYPAD_NUM	
			);

-- an example of a FSM to read and display the last four numbers entered from the keypad on the SSDs
lockbrain_controller: lockbrain
	PORT MAP (
				KEYPAD	=> KEYPAD_NUM,
				CLOCK		=> CLOCK_50,
				ENTER		=>	KEY(1),
				RESET		=> KEY(0),
				LED		=> LED
				
			);

-- Output key to a seven segment display (SSD)
SSD4:	ssd_controller
	PORT MAP(
				NUM => KEYPAD_NUM,
				HEX => HEX0
			);

END arch;
