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

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	