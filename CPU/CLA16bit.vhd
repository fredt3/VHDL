
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CLA16bit is
port (
		a,b	: IN std_logic_vector(15 downto 0);
		cin	: IN std_logic;
		s		: OUT std_logic_vector(15 downto 0);
		cout, oflow	: OUT std_logic
		);
end CLA16bit;

architecture LOGIC of CLA16bit is
	component CLA4bit is
		port (a,b	: IN std_logic_vector(3 downto 0);
		cin	: IN std_logic;
		s	: OUT std_logic_vector(3 downto 0);
		cinout, cout,G,P	: OUT std_logic
		);	
	end component;
	component CLAlogic is
		port (P,G	: IN std_logic_vector(3 downto 0);
		cin	: IN std_logic;
		C		: OUT std_logic_vector(3 downto 0)
		);
	end component;	
	
	signal c : std_logic_vector(15 downto 0);
	signal c2out : std_logic;
	signal CC : std_logic_vector(3 downto 0);
	signal GG : std_logic_vector(3 downto 0);
	signal PP : std_logic_vector(3 downto 0);
begin
		c1: CLA4bit Port Map(
			a => a(3 downto 0),
			b => b(3 downto 0),
			cin => cin,
			G => GG(0),
			P => PP(0),
			s => s(3 downto 0)
			--cout => c(0)
			);
		c2: CLA4bit Port Map(
			a => a(7 downto 4),
			b => b(7 downto 4),
			cin => CC(0),
			G => GG(1),
			P => PP(1),
			s => s(7 downto 4)
			--cout => c(0)
			);
		c3: CLA4bit Port Map(
			a => a(11 downto 8),
			b => b(11 downto 8),
			cin => CC(1),
			G => GG(2),
			P => PP(2),
			s => s(11 downto 8)
			--cout => c(0)
			);
		c4: CLA4bit Port Map(
			a => a(15 downto 12),
			b => b(15 downto 12),
			cin => CC(2),
			G => GG(3),
			P => PP(3),
			s => s(15 downto 12),
			cout => c2out
			);	
		c5: CLAlogic Port Map(
			cin => cin,
			C => CC,
			P => PP,
			G => GG
			);	
			
		cout <= CC(3);	
		oflow <= CC(3) XOR c2out;
			
		
end LOGIC;