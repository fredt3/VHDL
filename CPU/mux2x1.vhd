library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity mux2x1 is
port(	
		i0,i1 	: IN std_logic_vector(15 downto 0);
		s	   	: IN std_logic;
		o			: OUT std_logic_vector(15 downto 0)
	);
end mux2x1;

architecture logic of mux2x1 is
begin

	WITH s SELECT
		o <= i0 WHEN '0',
			  i1 WHEN '1';

end logic;
