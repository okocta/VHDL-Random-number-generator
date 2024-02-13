library ieee;
use ieee.std_logic_1164.all;

entity REGISTER_8BIT is
	port(DATA_IN: in std_logic_vector(7 downto 0);
	RESET: in std_logic;
	CLK: in std_logic;
	DATA_OUT: out std_logic_vector(7 downto 0));
end REGISTER_8BIT;

architecture arch of REGISTER_8BIT is
begin
	process(CLK, RESET)
	variable iDIN: std_logic_vector(7 downto 0) := "00000000";
	begin
		if RESET = '1' then
			iDIN := "00000000";
		else
			if (CLK'EVENT and CLK = '1') then
				iDIN := DATA_IN;
			end if;
		end if;
		DATA_OUT <= iDIN;
	end process;
end arch;