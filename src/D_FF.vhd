library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end D_FF;

architecture arch of D_FF is
begin
	process (CLK, RESET) 
	variable iQ: std_logic := '1';
	begin
		if RESET = '1' then
			iQ := '1';
		else
			if (CLK'event and CLK = '1')
				then iQ := D;
			end if;	
		end if;
		Q <= iQ;
	end process;
end arch;