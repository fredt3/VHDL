
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU16bit is
port (
		a,b : IN std_logic_vector(15 downto 0);
		cin	: IN std_logic;
		r, ta, tb		: OUT std_logic_vector(15 downto 0);
		s		: IN std_logic_vector (3 downto 0);
		cout, oflow, zero  : OUT std_logic
		);
end ALU16bit;

architecture LOGIC of ALU16bit is
	component FA16bit is
		port (a,b	: IN std_logic_vector(15 downto 0);
		cin	: IN std_logic;
		s		: OUT std_logic_vector(15 downto 0);
		cout, oflow	: OUT std_logic
		);
	end component;
	component CLA16bit is
		port (a,b	: IN std_logic_vector(15 downto 0);
		cin	: IN std_logic;
		s		: OUT std_logic_vector(15 downto 0);
		cout, oflow	: OUT std_logic
		);
	end component;
	
	signal addALU, slt, subALU : std_logic_vector(15 downto 0);
	signal notb, result : std_logic_vector (15 downto 0);
	signal coutADD, coutSUB, oADD,oSUB : std_logic;
	
begin
	ta <= a;
	tb <= b;
	notb <= (NOT B);

Add: CLA16bit Port Map(
			a => a,
			b => b,
			cin => cin,
			cout => coutADD,
			oflow => oADD,
			s => addALU
			);			

Sub: CLA16bit Port Map(
			a => a,
			b => notb,
			cin => '1',
			cout => coutSUB,
			oflow => oSUB,
			s => subALU
			);		
		
--SLT
		slt(0) <= subALU(15);
		slt(15 downto 1) <= "000000000000000";
		
			WITH s SELECT
		cout <= coutSUB WHEN "0011",
				  coutADD WHEN OTHERS;
				  
			WITH s SELECT
		oflow <= oSUB WHEN "0011",
				   oADD WHEN OTHERS;

			WITH s SELECT
		result <= A AND B WHEN "0000",
			  A OR B  WHEN "0001",
			  addALU	 WHEN "0010",
			  subALU	 WHEN "0011",
			  slt 	 WHEN "0111",
			  addALU WHEN OTHERS;
			  
		r <= result;	  
--Zero Detect
	zero <= NOT (result(15) or result(14) or result(13) or result(12) or result(11) or result(10) or result(9) or result(8) or result(7) or result(6) or result(5)or result(4) or result(3) or result(2) or result(1) or result(0));
			
		
end LOGIC;