library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library mylibrary;
use mylibrary.mytypes.all;

entity CPU is
port(	
	instrsim : out std_logic_vector(15 downto 0);
	pcsim : in std_logic_vector(15 downto 0);
	clk : IN std_logic;
	rst : IN std_logic;
	controlss : OUT std_logic_vector(8 downto 0);
	pcout : OUT std_logic_vector(15 downto 0);
	rr1, ta, tb : OUT std_logic_vector(15 downto 0);
	rr2 : OUT std_logic_vector(15 downto 0);
	rr3 : OUT std_logic_vector(15 downto 0);
	ofst : OUT std_logic_vector(15 downto 0);
	AO, alu2, alu1 : OUT std_logic_vector(15 downto 0);
	treadreg1, treadreg2, treadreg3	:	OUT std_logic_vector (3 downto 0);
	ts : out std_logic
	);
end CPU;

architecture logic of CPU is 

component control is
port(	
	i : IN std_logic_vector(3 downto 0);
	o : OUT std_logic_vector(8 downto 0)	
	);
end component;
component regfile is
port(	
	writedata				:	IN std_logic_vector(15 downto 0);
	writereg 				:	IN std_logic_vector (3 downto 0);
	regwrite, clk, rst			: 	IN std_logic;
	readreg1, readreg2, readreg3	:	IN std_logic_vector (3 downto 0);
	treadreg1, treadreg2, treadreg3	:	OUT std_logic_vector (3 downto 0);
	readdata1, readdata2,readdata3, readafterwrite :  OUT std_logic_vector(15 downto 0)
	);
end component;
component ALU16bit is
port(	
	a,b : IN std_logic_vector(15 downto 0);
	cin	: IN std_logic;
	r, ta, tb		: OUT std_logic_vector(15 downto 0);
	s		: IN std_logic_vector (3 downto 0);
	cout, oflow, zero  : OUT std_logic
	);
end component;
component CLA16bit is
port(	
	a,b	: IN std_logic_vector(15 downto 0);
	cin	: IN std_logic;
	s		: OUT std_logic_vector(15 downto 0);
	cout, oflow	: OUT std_logic
	);
end component;
component reg is
port(	
	d			:  IN std_logic_vector (15 downto 0);
	w, clk, rst		:  IN std_logic;
	s		:	OUT std_logic_vector (15 downto 0)
	);
end component;
component RAM is
port(	
	d			:  IN std_logic_vector (15 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end component;	
component DataRAM is
port(	
	address			:  IN std_logic_vector (15 downto 0);
	WriteData		:  IN std_logic_vector (15 downto 0);
	MemRead			: 	IN std_logic;
	MemWrite			:  IN std_logic;
	clk				:  IN std_logic;
	DataOut			:	OUT std_logic_vector (15 downto 0)
	);

end component;
component signextend4to16 is
port(	
	d			:  IN std_logic_vector (3 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end component;
component signextend8to16 is
port(	
	d			:  IN std_logic_vector (7 downto 0);
	s			:	OUT std_logic_vector (15 downto 0)
	);
end component;
component mux2x16 is
port(	
		i0,i1 	: IN std_logic_vector(15 downto 0);
		s	   	: IN std_logic;
		ts : out std_logic;
		o			: OUT std_logic_vector(15 downto 0)
	);
end component;
component mux2x4 is
port(	
		i0,i1 	: IN std_logic_vector(3 downto 0);
		s   	: IN std_logic;
		o			: OUT std_logic_vector(3 downto 0)
	);
end component;
component pc is
port(	
	d			:  IN std_logic_vector (15 downto 0);
	w, clk, rst:  IN std_logic;
	s			:	OUT std_logic_vector (15 downto 0) := "0000000000000000"
	);
end component;


signal instruct	 : std_logic_vector (15 downto 0);
signal aluIn1		 : std_logic_vector (15 downto 0);
signal aluIn2		 : std_logic_vector (15 downto 0);
signal PCsig		 : std_logic_vector (15 downto 0) := "0000000000000000";
signal PCIn			 : std_logic_vector (15 downto 0) := "0000000000000000";
signal ALUOut		 : std_logic_vector (15 downto 0);
signal readdata1out : std_logic_vector (15 downto 0);
signal readdata2out : std_logic_vector (15 downto 0);
signal readdata3out : std_logic_vector (15 downto 0);
signal DataRAMOut	 : std_logic_vector (15 downto 0);
signal writedataIn : std_logic_vector (15 downto 0);
signal adder1Out	 : std_logic_vector (15 downto 0);
signal adder2Out	 : std_logic_vector (15 downto 0);
signal offset		 : std_logic_vector (15 downto 0);
signal jumpoffset		 : std_logic_vector (15 downto 0);
signal muxBranchOut : std_logic_vector (15 downto 0);
signal writeRegIn		: std_logic_vector (3 downto 0);
signal branchextend		: std_logic_vector (15 downto 0);

--Control Signals
signal RegDest			: std_logic ;
signal Mem2Reg			: std_logic ;
signal ALUsrc1			: std_logic ;
signal ALUsrc2			: std_logic ;
signal jump				: std_logic ;
signal memRead			: std_logic ;
signal memWrite		: std_logic ;
signal branch			: std_logic ;
signal regwrite		: std_logic ;
signal controls : std_logic_vector(8 downto 0);

begin
instrsim <= instruct;
PCout <= PCsig;
rr1 <=readdata1out;
rr2 <=readdata2out;
rr3 <=readdata3out;
alu1 <= aluIn1;
alu2 <= aluIn2;
AO <= ALUOut;
ofst <= offset;
controlss <= controls;
RegDest <= controls(0);
Mem2Reg <= controls(1);
ALUsrc1 <= controls(2);
ALUsrc2 <= controls(3);
jump <= controls(4);
memRead <= controls(5);
memWrite <= controls(6);
branch <= controls(7);
regwrite <= controls(8);

--Reset: process (clk, rst)
--	begin
--		if rst = '1' then
--			PCin <= "0000000000000000";
--		end if;
--end process Reset;

ControlBox: control Port Map(
	i => instruct(15 downto 12),
	o => controls
	);
pc1: pc Port Map(
	d => PCin,
	w => '1',
	clk => clk,
	s => PCsig,
	rst => rst
	);
RAMcomp: RAM Port Map(
	d => PCsig,
	s => instruct
	);
DataRAM1: DataRAM Port Map(
	address => ALUOut,
	WriteData => readdata3out,
	MemRead => memRead,
	MemWrite => memWrite,
	DataOut => DataRAMOut,
	clk => clk
	);
RegisterFile: regfile Port Map(
	writedata => writedataIn,
	writereg => writeRegIn,
	regwrite => regwrite,
	clk => clk,
	readreg1 => instruct(11 downto 8),
	readreg2 => instruct(7 downto 4),
	readreg3 => instruct(3 downto 0),
	readdata1 => readdata1out, 
	readdata2 => readdata2out,
	readdata3 => readdata3out,
	rst => rst,
	treadreg1 => treadreg1,
	treadreg2 => treadreg2,
	treadreg3 => treadreg3
	);	
alu: ALU16bit Port Map(
	a => aluIn1,
	b => aluIn2,
	r => aluOut,
	s => instruct(15 downto 12),
	cin => '0',
	ta => ta,
	tb => tb
	);
adder1: CLA16bit Port Map(
	a => "0000000000000001",
	b => PCsig,
	s => adder1Out,
	cin => '0'
	);
adder2: CLA16bit Port Map(
	a => PCsig,
	b => branchextend,
	s => adder2Out,
	cin => '0'
	);	
muxRegDest: mux2x4 Port Map(
	i0 => instruct(7 downto 4),
	i1 => instruct(3 downto 0),
	s => RegDest,
	o => writeRegIn
	);
muxMem2Reg: mux2x16 Port Map(
	i0 => ALUOut,
	i1 => DataRAMOut,
	s => Mem2Reg,
	o => writedataIn
	);
muxALUsrc1: mux2x16 Port Map(
	i0 => readdata1out,
	i1 => PCsig,
	s => ALUsrc1,
	o => ALUIn1
	);
muxALUsrc2: mux2x16 Port Map(
	i0 => readdata2out,
	i1 => offset,
	s => controls(3),
	o => ALUIn2,
	ts => ts
	);
muxBranch: mux2x16 Port Map(
	i0 => adder1Out,
	i1 => adder2Out,
	s => ((NOT(ALUIn1(0) OR ALUIn1(1) OR ALUIn1(2) OR ALUIn1(3) OR ALUIn1(4) OR ALUIn1(5) OR ALUIn1(6) OR ALUIn1(7) OR ALUIn1(8) OR ALUIn1(9) OR ALUIn1(10) OR ALUIn1(11) OR ALUIn1(12) OR ALUIn1(13) OR ALUIn1(14) OR ALUIn1(15))) AND branch),
	o => muxBranchOut
	);
muxJump: mux2x16 Port Map(
	i0 => muxBranchOut,
	i1 => readdata1out,
	s => jump,
	o => PCin
	);
--muxJumpShift: mux2x16 Port Map(
--	i0 => offset,
--	i1 => jumpoffset,
--	s => jump,
--	o => offsetaftermux
--	);
sExtend4to16: signextend4to16 Port Map(
	d => instruct(3 downto 0),
	s => offset
	);
sExtend8to16: signextend8to16 Port Map(
	d => instruct(7 downto 0),
	s => branchextend
	);
	
	--jumpoffset <= offset(14 downto 0) & '0';
	
end logic;
