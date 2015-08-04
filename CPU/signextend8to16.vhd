library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity signextend8to16 is
-- put your port definition here
port(	
	d			:  IN std_logic_vector (7 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end signextend8to16;

architecture logic of signextend8to16 is
	signal sig	:	std_logic_vector(15 downto 0);
begin

	sig(7 downto 0) <= d;
	sig(8) <= d(7);
	sig(9) <= d(7);
	sig(10) <= d(7);
	sig(11) <= d(7);
	sig(12) <= d(7);
	sig(13) <= d(7);
	sig(14) <= d(7);
	sig(15) <= d(7);
	
	s <= sig;
	

	
end logic;
