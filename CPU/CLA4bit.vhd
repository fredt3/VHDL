
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CLA4bit is
port (a,b	: IN std_logic_vector(3 downto 0);
		cin	: IN std_logic;
		s	: OUT std_logic_vector(3 downto 0);
		cinout, cout,G,P	: OUT std_logic
		);
end CLA4bit;

architecture LOGIC of CLA4bit is
	component CLA1bit is
		port(a,b		: IN std_logic;
		cin			: IN std_logic;
		s,g,p, cout	: OUT std_logic
		);
	end component;
	signal c : std_logic_vector(2 downto 0);
	signal gg : std_logic_vector(3 downto 0);
	signal pp : std_logic_vector(3 downto 0);
	
begin

c1: CLA1bit Port Map(
			a => a(0),
			b => b(0),
			cin => cin,
			g => gg(0),
			p => pp(0),
			s => s(0)
			--cout => c(0)
			);
c2: CLA1bit Port Map(
			a => a(1),
			b => b(1),
			cin => gg(0) OR (pp(0) AND cin),
			g => gg(1),
			p => pp(1),
			s => s(1)
			--cout => c(1)
			);
c3: CLA1bit Port Map(
			a => a(2),
			b => b(2),
			cin => gg(1) OR (pp(1) AND gg(0)) OR (pp(1) AND pp(0) AND cin),
			g => gg(2),
			p => pp(2),
			s => s(2),
			cout => cout
			);
c4: CLA1bit Port Map(
			a => a(3),
			b => b(3),
			cin => gg(2) OR (pp(2) AND gg(1)) OR (pp(2) AND pp(1) AND gg(0)) OR (pp(2) AND pp(1) AND pp(0) AND cin),
			g => gg(3),
			p => pp(3),
			s => s(3)
			--cout => cout
			);			
			
			G <= (gg(0) AND pp(3) AND pp(2) AND pp(1)) OR (gg(1) AND pp(3) AND pp(2)) OR (gg(2) AND pp(3)) OR gg(3);
			P <= pp(0) AND pp(1) AND pp(2) AND pp(3);	
			--cinout <= c(2);
			
		
end LOGIC;