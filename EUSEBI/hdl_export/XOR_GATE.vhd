library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity XOR_GATE is
	port (A, B: in STD_LOGIC;
	Y: out STD_LOGIC);
end XOR_GATE;

architecture arch of XOR_GATE is
begin
	process(A, B)
	begin
		Y <= A xor B;
	end process;
end arch;
