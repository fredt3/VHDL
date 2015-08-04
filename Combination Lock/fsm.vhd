-- simple fsm to save and display the last 4 numbers on 4 ssds.
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY fsm IS
PORT (
		CLOCK_50			: IN   	STD_LOGIC;	
		RESET				: IN   	STD_LOGIC;
		N					: IN	STD_LOGIC_VECTOR (3 DOWNTO 0);
		p_state				: OUT	STD_LOGIC_VECTOR (2 DOWNTO 0); -- for debuging 
		N1, N2, N3, N4		: OUT 	STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END fsm;

ARCHITECTURE arch OF fsm IS

-- state type
TYPE state IS (first, wait_n, new_n, new_n_off, update );
SIGNAL pr_state, nx_state: state;

---------------  ARCHITECTURE BODY   -----------------------------------

BEGIN

------------------------- process for lower section of FSM ----------------------------------
lower_section:
PROCESS (CLOCK_50, RESET)
VARIABLE num, num1, num2, num3, num4		: STD_LOGIC_VECTOR (3 DOWNTO 0) ;
BEGIN
	IF (RESET = '0') THEN
		pr_state <= first;
		num	 := (OTHERS =>'0');
		num1 := (OTHERS =>'0');
		num2 := (OTHERS =>'0');
		num3 := (OTHERS =>'0');
		num4 := (OTHERS =>'0');
	ELSIF (CLOCK_50'EVENT AND CLOCK_50 = '1') THEN 	-- rising edge
		pr_state <= nx_state;			
		IF (pr_state = new_n) THEN
			num := N;
		ELSIF (pr_state = update) THEN
			num4 := num3;
			num3 := num2;
			num2 := num1;
			num1 := num;		
		END IF;
	END IF;
	N1 <= num1;
	N2 <= num2;
	N3 <= num3;
	N4 <= num4;
END PROCESS lower_section;

------------------------- process for upper section of FSM ----------------------------------  
upper_section:
PROCESS (pr_state, N)
BEGIN
	CASE pr_state IS
	
		WHEN first =>
			nx_state <= wait_n;
			p_state <= "000";
		WHEN wait_n =>
			IF (N /= "1111") THEN
				nx_state <= new_n;
			ELSE
				nx_state <= wait_n;
			END IF;
			p_state <= "001";
		WHEN new_n =>
			nx_state <= new_n_off;
			p_state <= "010";
		WHEN new_n_off =>
			IF (N = "1111") THEN
				nx_state <= update;
			ELSE
				nx_state <= new_n_off;
			END IF;
			p_state <= "011";
		WHEN update =>
			nx_state <= wait_n;
			p_state <= "100";
		WHEN OTHERS =>
			nx_state <= first;
			p_state <= "111";
			
	END CASE;
	
END PROCESS upper_section ;

END arch;