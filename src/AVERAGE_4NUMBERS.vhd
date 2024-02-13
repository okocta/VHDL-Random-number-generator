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