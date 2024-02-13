library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LFSR_4BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(3 downto 0));
end LFSR_4BIT;

architecture arch of LFSR_4BIT is 



component D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end component;

component XOR_GATE is					   	
	port(A, B: in STD_LOGIC;
		Y: out STD_LOGIC);
end component;
signal Qout: STD_LOGIC_VECTOR(3 downto 0):="0000"; 
signal s1: STD_LOGIC; 

begin

	C0: XOR_GATE port map(Qout(2), Qout(3), s1);
	C1: D_FF port map(s1, CLK, RESET, Qout(0));
	C2: D_FF port map(Qout(0), CLK, RESET, Qout(1));
	C3: D_FF port map(Qout(1), CLK, RESET, Qout(2));
	C4: D_FF port map(Qout(2), CLK, RESET, Qout(3));  	  
	Q <= Qout;
end arch;

