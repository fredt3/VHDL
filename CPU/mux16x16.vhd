library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity mux16x16 is
-- put your port definition here
port(	
	a : IN array16x16;
	s : IN std_logic_vector(3 downto 0);
	d : OUT std_logic_vector(15 downto 0)
	);
end mux16x16;

architecture logic of mux16x16 is
	--signal rf : array16x16;
begin
	--rf(0) <= a(0);

	WITH s SELECT
	d <=  a(0) WHEN "0000",
			a(1) WHEN "0001",
			a(2) WHEN "0010",
			a(3) WHEN "0011",
			a(4) WHEN "0100",
			a(5) WHEN "0101",
			a(6) WHEN "0110",
			a(7) WHEN "0111",
			a(8) WHEN "1000",
			a(9) WHEN "1001",
			a(10) WHEN "1010",
			a(11) WHEN "1011",
			a(12) WHEN "1100",
			a(13) WHEN "1101",
			a(14) WHEN "1110",
			a(15) WHEN OTHERS;
end logic;
