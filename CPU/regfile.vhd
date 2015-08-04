library ieee;
use ieee.std_logic_1164.all;

library mylibrary;
use mylibrary.mytypes.all;
use ieee.numeric_std.all;

entity regfile is
-- put your port definition here
port(	
	writedata				:	IN std_logic_vector(15 downto 0);
	writereg 				:	IN std_logic_vector (3 downto 0);
	regwrite, clk, rst			: 	IN std_logic;
	readreg1, readreg2, readreg3	:	IN std_logic_vector (3 downto 0);
	treadreg1, treadreg2, treadreg3	:	OUT std_logic_vector (3 downto 0);
	readdata1, readdata2,readdata3, readafterwrite :  OUT std_logic_vector(15 downto 0)
	);
end regfile;

architecture logic of regfile is
 component decoder4to16 is
	port(	
		a : IN std_logic_vector(3 downto 0);
		s : OUT std_logic_vector(15 downto 0)	
		);
 end component;
 component mux16x16 is
	port(	
		a 			: IN array16x16;
		s 			: IN std_logic_vector(3 downto 0);
		d 			: OUT std_logic_vector(15 downto 0)
		);
 end component;
 component reg is
	port(	
		d			:  IN std_logic_vector (15 downto 0);
		w, clk, rst	:  IN std_logic;
		s			:	OUT std_logic_vector (15 downto 0)
	);
 end component;
-- put your component and signal definitions here
	signal rf : array16x16;
	signal x	:	std_logic_vector(15 downto 0);
	signal i : integer;
begin

treadreg1 <= readreg1;
treadreg2 <= readreg2;
treadreg3 <= readreg3;

c1: decoder4to16 Port Map(
	a => writereg,
	s => x
	);
c2: mux16x16 Port Map(
	a => rf,
	s => readreg1,
	d => readdata1
	);
c3: mux16x16 Port Map(
	a => rf,
	s => readreg2,
	d => readdata2
	);
c4: mux16x16 Port Map(
	a => rf,
	s => readreg3,
	d => readdata3
	);
r0: reg Port Map(
	s => rf(0),
	d => writedata,
	clk => clk,
	w => x(0) AND regwrite,
	rst => rst
	);
r1: reg Port Map(
	s => rf(1),
	d => writedata,
	clk => clk,
	w => x(1) AND regwrite,
	rst => rst
	);
r2: reg Port Map(
	s => rf(2),
	d => writedata,
	clk => clk,
	w => x(2) AND regwrite,
	rst => rst
	);
r3: reg Port Map(
	s => rf(3),
	d => writedata,
	clk => clk,
	w => x(3) AND regwrite,
	rst => rst
	);
r4: reg Port Map(
	s => rf(4),
	d => writedata,
	clk => clk,
	w => x(4) AND regwrite,
	rst => rst
	);
r5: reg Port Map(
	s => rf(5),
	d => writedata,
	clk => clk,
	w => x(5) AND regwrite,
	rst => rst
	);
r6: reg Port Map(
	s => rf(6),
	d => writedata,
	clk => clk,
	w => x(6) AND regwrite,
	rst => rst
	);
r7: reg Port Map(
	s => rf(7),
	d => writedata,
	clk => clk,
	w => x(7) AND regwrite,
	rst => rst
	);
r8: reg Port Map(
	s => rf(8),
	d => writedata,
	clk => clk,
	w => x(8) AND regwrite,
	rst => rst
	);
r9: reg Port Map(
	s => rf(9),
	d => writedata,
	clk => clk,
	w => x(9) AND regwrite,
	rst => rst
	);
r10: reg Port Map(
	s => rf(10),
	d => writedata,
	clk => clk,
	w => x(10) AND regwrite,
	rst => rst
	);
r11: reg Port Map(
	s => rf(11),
	d => writedata,
	clk => clk,
	w => x(11) AND regwrite,
	rst => rst
	);
r12: reg Port Map(
	s => rf(12),
	d => writedata,
	clk => clk,
	w => x(12) AND regwrite,
	rst => rst
	);
r13: reg Port Map(
	s => rf(13),
	d => writedata,
	clk => clk,
	w => x(13) AND regwrite,
	rst => rst
	);
r14: reg Port Map(
	s => rf(14),
	d => writedata,
	clk => clk,
	w => x(14) AND regwrite,
	rst => rst
	);
r15: reg Port Map(
	s => rf(15),
	d => writedata,
	clk => clk,
	w => x(15) AND regwrite,
	rst => rst
	);
	
	i <= to_integer(unsigned(writereg));
	readafterwrite <= rf(i);

end logic;
