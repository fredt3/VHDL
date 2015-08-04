library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CLA1bit is
port (a,b	: IN std_logic;
		cin	: IN std_logic;
		s,g,p	: OUT std_logic;
		cout	: OUT std_logic
		);
end CLA1bit;

architecture LOGIC of CLA1bit is
begin
	
		s <= a XOR b XOR cin;
		cout <= (a OR b) AND (a OR cin) AND (b OR cin);
		g <= a AND b;
		p <= a OR b;
end LOGIC;