library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CLAlogic is
port (P,G	: IN std_logic_vector(3 downto 0);
		cin	: IN std_logic;
		C		: OUT std_logic_vector(3 downto 0)
		);
end CLAlogic;

architecture LOGIC of CLAlogic is

begin
	
	C(0) <= G(0) OR (P(0) AND cin);
	C(1) <= G(1) OR (P(1) AND G(0)) OR (P(1) AND P(0) AND cin);
	C(2) <= G(2) OR (P(2) AND G(1)) OR (P(2) AND P(1) AND G(0)) OR (P(2) AND P(1) AND P(0) AND cin);
	C(3) <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND P(1) AND G(1)) OR (P(3) AND P(2) AND P(1) AND P(0) AND cin);
		
end LOGIC;