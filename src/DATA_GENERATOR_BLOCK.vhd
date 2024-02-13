library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DATA_GENERATOR_BLOCK is
	port(CLK, RESET: in std_logic;
		CONTROL: in std_logic_vector(2 downto 0);
		DATA: out std_logic_vector(7 downto 0));
end DATA_GENERATOR_BLOCK;

architecture arch of DATA_GENERATOR_BLOCK is

component LFSR_4BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component LFSR_8BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal Q4: std_logic_vector(3 downto 0);
signal Q8: std_logic_vector(7 downto 0);
begin			 
	C0: LFSR_4BIT port map(CLK, RESET, Q4);
	C1: LFSR_8Bit port map(CLK, RESET, Q8);
	process (RESET, Q4, Q8, CONTROL)
	variable iDATA: std_logic_vector(7 downto 0) := "00000000";
	begin
		if (RESET = '1') then 
			iData := "00000000";		
		else
			case CONTROL is
				when "000" => iDATA := "00000000";
				when "010" => iDATA := "00111111";
				when "011" => iDATA := "00111101";
				when "110" => iDATA := "0000" & Q4;
				when others => iDATA := Q8;
			end case;
		end if;
		DATA <= iDATA;
	end process;
end arch;