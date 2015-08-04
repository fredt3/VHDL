library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity decoder4to16 is
-- put your port definition here
port(	
	a : IN std_logic_vector(3 downto 0);
	s : OUT std_logic_vector(15 downto 0)	
	);
end decoder4to16;

architecture logic of decoder4to16 is
	signal x : array16x16;
begin

	x(0)  <= "0000000000000001";
	x(1)  <= "0000000000000010";
	x(2)  <= "0000000000000100";
	x(3)  <= "0000000000001000";
	x(4)  <= "0000000000010000";
	x(5)  <= "0000000000100000";
	x(6)  <= "0000000001000000";
	x(7)  <= "0000000010000000";
	x(8)  <= "0000000100000000";
	x(9)  <= "0000001000000000";
	x(10) <= "0000010000000000";
	x(11) <= "0000100000000000";
	x(12) <= "0001000000000000";
	x(13) <= "0010000000000000";
	x(14) <= "0100000000000000";
	x(15) <= "1000000000000000";

	WITH a SELECT
	s <=  x(0)  WHEN "0000",
			x(1)  WHEN "0001",
			x(2)  WHEN "0010",
			x(3)  WHEN "0011",
			x(4)  WHEN "0100",
			x(5)  WHEN "0101",
			x(6)  WHEN "0110",
			x(7)  WHEN "0111",
			x(8)  WHEN "1000",
			x(9)  WHEN "1001",
			x(10) WHEN "1010",
			x(11) WHEN "1011",
			x(12) WHEN "1100",
			x(13) WHEN "1101",
			x(14) WHEN "1110",
			x(15) WHEN OTHERS;

end logic;
