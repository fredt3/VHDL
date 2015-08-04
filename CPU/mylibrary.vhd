library ieee;
use ieee.std_logic_1164.all;
    
 package mytypes is
    type array16x16 is array(0 to 15) of std_logic_vector(15 downto 0);
	 type array8x256 is array(0 to 255) of std_logic_vector(7 downto 0);
end package mytypes;