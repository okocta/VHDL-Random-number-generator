library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FREQUENCY_DIVIDER is
	port(CLK_IN: in std_logic;
	RESET: in std_logic;
	CLK_OUT: out std_logic);
end FREQUENCY_DIVIDER;

architecture arch of FREQUENCY_DIVIDER is
begin
	process(CLK_IN, RESET)					   
	variable count: std_logic_vector(25 downto 0) := (others => '0');
	begin
		if RESET = '1' then
			count := (others => '0');
		else			 
			if (CLK_IN'EVENT and CLK_IN = '1') then 
				count := std_logic_vector(unsigned(count) + "1");
			end if;
		end if;
		CLK_OUT <= count(25);
	end process;
end arch;
