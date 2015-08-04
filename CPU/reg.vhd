library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity reg is
-- put your port definition here
port(	
	d			:  IN std_logic_vector (15 downto 0);
	w, clk, rst:  IN std_logic;
	s			:	OUT std_logic_vector (15 downto 0) := "0000000000000000"
	);
end reg;

architecture logic of reg is
	signal REGISTERVALUE	:	std_logic_vector(15 downto 0) := "0000000000000000";
begin

writer: process (clk, w, rst, d)
begin
if clk'event and clk = '1' then
	if w = '1' then
		REGISTERVALUE <= d;
	end if;
	if rst = '1' then
		REGISTERVALUE <= "0000000000000001";
		end if;
end if;
end process writer;

s <= REGISTERVALUE;


	
end logic;
