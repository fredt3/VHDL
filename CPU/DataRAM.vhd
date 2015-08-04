library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library mylibrary;
use mylibrary.mytypes.all;

entity DataRAM is
port(	
	address			:  IN std_logic_vector (15 downto 0);
	WriteData		:  IN std_logic_vector (15 downto 0);
	MemRead			: 	IN std_logic;
	MemWrite			:  IN std_logic;
	clk				:  IN std_logic;
	DataOut			:	OUT std_logic_vector (15 downto 0)
	);
end DataRAM;

architecture logic of DataRAM is
signal x : array16x16;
signal addr: integer;
begin

	
	addr <= to_integer(unsigned(address));

		
	
	RAMwrite: process (clk, MemRead, MemWrite, WriteData, x, addr)
	begin
		if MemWrite = '1' then
			x(addr) <= WriteData(15 downto 0);
		end if;
		if MemRead = '1' then
			DataOut <= x(addr);
		end if;
	end process RAMwrite;
	
end logic;
