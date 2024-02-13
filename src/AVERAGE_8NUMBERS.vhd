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