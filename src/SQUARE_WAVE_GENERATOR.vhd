library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;		

entity SQUARE_WAVE_GENERATOR is
	port(CLK_IN: in std_logic;
	RESET: in std_logic;
	CLK_OUT: out std_logic);
end SQUARE_WAVE_GENERATOR;

architecture arch of SQUARE_WAVE_GENERATOR is
begin
	process(CLK_IN, RESET)
	variable count : std_logic_vector (2 downto 0) := "000";
	begin
		if RESET = '1' then
			count := "000";
		else
			if CLK_IN'EVENT and CLK_IN = '1' then
				count := count + 1;
			end if;
		end if;
		CLK_OUT <= count(2);
	end process;	  
end arch;