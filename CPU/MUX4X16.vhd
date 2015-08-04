library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX4X16 is
Port (i0,i1,i2,i3 : IN std_logic_vector(15 downto 0);
		s	   : IN std_logic_vector(1 downto 0);
		o			   : OUT std_logic_vector(15 downto 0)
		);
END MUX4X16;

architecture ARCH of MUX4X16 is
begin

	WITH s SELECT
		o <= i0 WHEN "00",
			  i1 WHEN "01",
			  i2 WHEN "10",
			  i3 WHEN OTHERS ;
END ARCH;