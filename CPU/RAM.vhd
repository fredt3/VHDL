library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library mylibrary;
use mylibrary.mytypes.all;

entity RAM is
port(	
	d			:  IN std_logic_vector (15 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end RAM;

architecture logic of RAM is
	signal x : array16x16;
	signal addr1: integer;
	signal addr2: integer;
begin

	
	addr1 <= to_integer(unsigned(d));
		
	x(0) <= "0011000000000000";
	x(1) <= "1000000000000100";
	x(2) <= "0011000000000000";
	x(3) <= "1000000000000100";
	x(4) <= "0011000000000000";
	x(5) <= "1000000000000100";
	x(6) <= "0011000000000000";
	x(7) <= "1000000000000100";
	x(8) <= "0011000000000000";
	x(9) <= "1000000000000100";
	x(10) <= "0011000000000000";
	x(11) <= "1000000000000100";
	x(12) <= "0011000000000000";
	x(13) <= "1000000000000100";
	x(14) <= "0011000000000000";
	x(15) <= "1000000000000100";
	
	s <= x(addr1);
	

	
end logic;
