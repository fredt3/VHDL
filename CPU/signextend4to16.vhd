library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity signextend4to16 is
-- put your port definition here
port(	
	d			:  IN std_logic_vector (3 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end signextend4to16;

architecture logic of signextend4to16 is
	signal sig	:	std_logic_vector(15 downto 0);
begin

	sig(3 downto 0) <= d;
	sig(4) <= d(3);
	sig(5) <= d(3);
	sig(6) <= d(3);
	sig(7) <= d(3);
	sig(8) <= d(3);
	sig(9) <= d(3);
	sig(10) <= d(3);
	sig(11) <= d(3);
	sig(12) <= d(3);
	sig(13) <= d(3);
	sig(14) <= d(3);
	sig(15) <= d(3);
	
	s <= sig;
	

	
end logic;
