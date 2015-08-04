library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;

entity control is
-- put your port definition here
port(	
	i : IN std_logic_vector(3 downto 0);
	o : OUT std_logic_vector(8 downto 0)	
	);
end control;

architecture logic of control is
	signal ANDsig 		: std_logic_vector(8 downto 0);
	signal ORsig 		: std_logic_vector(8 downto 0);
	signal ADD 			: std_logic_vector(8 downto 0);
	signal SUB 			: std_logic_vector(8 downto 0);
	signal SLT			: std_logic_vector(8 downto 0);
	signal ADDI 		: std_logic_vector(8 downto 0);
	signal BRA	 		: std_logic_vector(8 downto 0);
	signal LW	 		: std_logic_vector(8 downto 0);
	signal SW 			: std_logic_vector(8 downto 0);
	signal JMPL 		: std_logic_vector(8 downto 0);
	
	
begin
--signal RegDest			: std_logic;
--signal Mem2Reg			: std_logic;
--signal ALUsrc1			: std_logic;
--signal ALUsrc2			: std_logic;
--signal jump				: std_logic;
--signal memRead			: std_logic;
--signal memWrite			: std_logic;
--signal branch			: std_logic;
--signal regwrite			: std_logic;

	ANDsig  	<= "100000001";
	ORsig 	<= "100000001";
	ADD  		<= "100000001";
	SUB  		<= "100000001";
	SLT  		<= "100000001";
	ADDI		<= "000100001";
	BRA		<= "000000010";
	LW  		<= "110001001";
	SW  		<= "110000100";
	JMPL 		<= "001110001";

	WITH i SELECT
	o <=  ANDsig  		WHEN "0000",
			ORsig	  		WHEN "0001",
			ADD  			WHEN "0010",
			SUB  			WHEN "0011",
			SLT  			WHEN "0111",
			ADDI  		WHEN "1000",
			BRA  			WHEN "1001",
			LW 			WHEN "1010",
			SW 			WHEN "1011",
			JMPL 			WHEN "1111",
			"000000000" 	WHEN OTHERS;

end logic;
