library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LFSR_4BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(3 downto 0));
end LFSR_4BIT;

architecture arch of LFSR_4BIT is 

signal Qout: STD_LOGIC_VECTOR(3 downto 0):="0000"; --numarul generat
signal sgn: STD_LOGIC; --input from the xor gate

component D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end component;

component XOR_GATE is					   	
	port(A, B: in STD_LOGIC;
		Z: out STD_LOGIC);
end component;

begin
	C0: XOR_GATE port map(Qout(1), Qout(3), sgn);
	C1: D_FF port map(sgn, CLK, RESET, Qout(0));
	C2: D_FF port map(Qout(0), CLK, RESET, Qout(1));
	C3: D_FF port map(Qout(1), CLK, RESET, Qout(2));
	C4: D_FF port map(Qout(2), CLK, RESET, Qout(3));  	  
	Q <= Qout;
end arch;