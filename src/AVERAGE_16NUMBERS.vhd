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