library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AVERAGE_COMPUTER_BLOCK is
	port(DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	FILTER: in std_logic_vector(2 downto 0);  
	RESET: in std_logic;
	AVERAGE: out std_logic_vector(7 downto 0));
end AVERAGE_COMPUTER_BLOCK;

architecture arch of AVERAGE_COMPUTER_BLOCK is

component REGISTER_8BIT is
	port(DATA_IN: in std_logic_vector(7 downto 0);
	RESET: in std_logic;
	CLK: in std_logic;
	DATA_OUT: out std_logic_vector(7 downto 0));
end component;

component AVERAGE_2NUMBERS is
	port(N1: in std_logic_vector(7 downto 0); 
	N2: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end component;

component AVERAGE_4NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end component; 

component AVERAGE_8NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	N5: in std_logic_vector(7 downto 0);
	N6: in std_logic_vector(7 downto 0);
	N7: in std_logic_vector(7 downto 0);
	N8: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end component;

component AVERAGE_16NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	N5: in std_logic_vector(7 downto 0);
	N6: in std_logic_vector(7 downto 0);
	N7: in std_logic_vector(7 downto 0);
	N8: in std_logic_vector(7 downto 0);
	N9: in std_logic_vector(7 downto 0);
	N10: in std_logic_vector(7 downto 0);
	N11: in std_logic_vector(7 downto 0);
	N12: in std_logic_vector(7 downto 0);
	N13: in std_logic_vector(7 downto 0);
	N14: in std_logic_vector(7 downto 0);
	N15: in std_logic_vector(7 downto 0);
	N16: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end component;

type NUMBERS_TYPE is array (0 to 15) of std_logic_vector(7 downto 0);  
signal AVERAGE_LAST2: std_logic_vector(7 downto 0);
signal AVERAGE_LAST4: std_logic_vector(7 downto 0);
signal AVERAGE_LAST8: std_logic_vector(7 downto 0);
signal AVERAGE_LAST16: std_logic_vector(7 downto 0);
signal NUM: NUMBERS_TYPE;

begin
	Registers: for I in 0 to 15 generate
		L1: if I = 0 generate
			L2: REGISTER_8BIT port map (DIN, RESET, CLK, NUM(0));
		end generate;
		L3:  if I > 0 generate
			L3: REGISTER_8BIT port map (NUM(I - 1), RESET, CLK, NUM(I));
		end generate;
	end generate;	
	AVG_OF_LAST2: AVERAGE_2NUMBERS port map(NUM(0), NUM(1), AVERAGE_LAST2);
	AVG_OF_LAST4: AVERAGE_4NUMBERS port map(NUM(0), NUM(1), NUM(2), NUM(3), AVERAGE_LAST4);
	AVG_OF_LAST8: AVERAGE_8NUMBERS port map(NUM(0), NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), NUM(6), NUM(7), AVERAGE_LAST8);
	AVG_OF_LAST16: AVERAGE_16NUMBERS port map(NUM(0), NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), NUM(6), NUM(7), NUM(8), NUM(9), NUM(10), NUM(11), NUM(12), NUM(13), NUM(14), NUM(15), AVERAGE_LAST16);
	process(FILTER, AVERAGE_LAST2, AVERAGE_LAST4, AVERAGE_LAST8, AVERAGE_LAST16)
	variable AVG: std_logic_vector(7 downto 0) := "00000000";
	begin 
		case FILTER	is
			when "100" => AVG := AVERAGE_LAST2;
			when "101" => AVG := AVERAGE_LAST4;
			when "110" => AVG := AVERAGE_LAST8;
			when "111" => AVG := AVERAGE_LAST16;
			when others => null;
		end case;
	AVERAGE <= AVG;
	end process;
end arch;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity AVERAGE_2NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);  
	N2: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end AVERAGE_2NUMBERS;

architecture arch of AVERAGE_2NUMBERS is
signal SUM: std_logic_vector(8 downto 0);
begin 
	SUM <= ('0' & N1) + ('0' & N2);
	AVERAGE_OUT <= SUM (8 downto 1);
end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AVERAGE_4NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end AVERAGE_4NUMBERS;

architecture arch of AVERAGE_4NUMBERS is  
signal SUM_FIRST2: std_logic_vector(8 downto 0);
signal SUM_LAST2: std_logic_vector(8 downto 0);
signal SUM: std_logic_vector(9 downto 0);
begin
	SUM_FIRST2 <= ('0' & N1) + ('0' & N2);
	SUM_LAST2 <= ('0' & N3) + ('0' & N4);
	SUM <= ('0' & SUM_FIRST2) + ('0' & SUM_LAST2);
	AVERAGE_OUT <= SUM(9 downto 2);
end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AVERAGE_8NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	N5: in std_logic_vector(7 downto 0);
	N6: in std_logic_vector(7 downto 0);
	N7: in std_logic_vector(7 downto 0);
	N8: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end AVERAGE_8NUMBERS;

architecture arch of AVERAGE_8NUMBERS is  
signal SUM1: std_logic_vector(8 downto 0);
signal SUM2: std_logic_vector(8 downto 0);
signal SUM3: std_logic_vector(8 downto 0);
signal SUM4: std_logic_vector(8 downto 0);
signal SUM: std_logic_vector(10 downto 0);
begin
	SUM1 <= ('0' & N1) + ('0' & N2);
	SUM2 <= ('0' & N3) + ('0' & N4);
	SUM3 <= ('0' & N5) + ('0' & N6);
	SUM4 <= ('0' & N7) + ('0' & N8);
	SUM <= ('0' & (('0' & SUM1) + ('0' & SUM2))) + ('0' & (('0' & SUM3) + ('0' & SUM4)));
	AVERAGE_OUT <= SUM(10 downto 3);
end arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AVERAGE_16NUMBERS is
	port(N1: in std_logic_vector(7 downto 0);
	N2: in std_logic_vector(7 downto 0);
	N3: in std_logic_vector(7 downto 0);
	N4: in std_logic_vector(7 downto 0);
	N5: in std_logic_vector(7 downto 0);
	N6: in std_logic_vector(7 downto 0);
	N7: in std_logic_vector(7 downto 0);
	N8: in std_logic_vector(7 downto 0);
	N9: in std_logic_vector(7 downto 0);
	N10: in std_logic_vector(7 downto 0);
	N11: in std_logic_vector(7 downto 0);
	N12: in std_logic_vector(7 downto 0);
	N13: in std_logic_vector(7 downto 0);
	N14: in std_logic_vector(7 downto 0);
	N15: in std_logic_vector(7 downto 0);
	N16: in std_logic_vector(7 downto 0);
	AVERAGE_OUT: out std_logic_vector(7 downto 0));
end AVERAGE_16NUMBERS;

architecture arch of AVERAGE_16NUMBERS is  
signal SUM1: std_logic_vector(8 downto 0);
signal SUM2: std_logic_vector(8 downto 0);
signal SUM3: std_logic_vector(8 downto 0);
signal SUM4: std_logic_vector(8 downto 0);
signal SUM5: std_logic_vector(8 downto 0);
signal SUM6: std_logic_vector(8 downto 0);
signal SUM7: std_logic_vector(8 downto 0);
signal SUM8: std_logic_vector(8 downto 0);
signal SUM12: std_logic_vector(9 downto 0);
signal SUM34: std_logic_vector(9 downto 0);
signal SUM56: std_logic_vector(9 downto 0);
signal SUM78: std_logic_vector(9 downto 0);
signal SUM: std_logic_vector(11 downto 0);
begin
	SUM1 <= ('0' & N1) + ('0' & N2);
	SUM2 <= ('0' & N3) + ('0' & N4);
	SUM3 <= ('0' & N5) + ('0' & N6);
	SUM4 <= ('0' & N7) + ('0' & N8);
	SUM5 <= ('0' & N9) + ('0' & N10);
	SUM6 <= ('0' & N11) + ('0' & N12);
	SUM7 <= ('0' & N13) + ('0' & N14);
	SUM8 <= ('0' & N15) + ('0' & N16);
	SUM12 <= ('0' & SUM1) + ('0' & SUM2);
	SUM34 <= ('0' & SUM3) + ('0' & SUM4);
	SUM56 <= ('0' & SUM5) + ('0' & SUM6);
	SUM78 <= ('0' & SUM7) + ('0' & SUM8);
	SUM <= ('0' & (('0' & SUM12) + ('0' & SUM34))) + ('0' & (('0' & SUM56) + ('0' & SUM78)));
	AVERAGE_OUT <= SUM(11 downto 4);
end arch;
		
	