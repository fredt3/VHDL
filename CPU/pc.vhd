library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity pc is
-- put your port definition here
port(	
	d			:  IN std_logic_vector (15 downto 0);
	w, clk, rst:  IN std_logic;
	s			:	OUT std_logic_vector (15 downto 0) := "0000000000000000"
	);
end pc;

architecture logic of pc is
	signal REGISTERVALUE	:	std_logic_vector(15 downto 0);
	signal xfx: std_logic := '0';
begin

writer: process (clk, w, rst, d)
begin
if clk'event and clk = '1' then
	if w = '1' then
		REGISTERVALUE <= d;
	end if;
	if rst = '1' then
		REGISTERVALUE <= "0000000000000000";
		end if;
	if xfx = '0' then
		xfx <= '1';
		REGISTERVALUE <= "0000000000000000";
	end if;
end if;
end process writer;

s <= REGISTERVALUE;


	

	
end logic;
