library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity average_8numbers is
    port (
        nr1 : in std_logic_vector(7 downto 0);
        nr2 : in std_logic_vector(7 downto 0);
        nr3 : in std_logic_vector(7 downto 0);
        nr4 : in std_logic_vector(7 downto 0);
        nr5 : in std_logic_vector(7 downto 0);
        nr6 : in std_logic_vector(7 downto 0);
        nr7 : in std_logic_vector(7 downto 0);
        nr8 : in std_logic_vector(7 downto 0);
        avg : out std_logic_vector(7 downto 0)
    );
end average_8numbers;

architecture arch_avg8 of average_8numbers is

    signal sum_first2 : std_logic_vector(8 downto 0);
    signal sum_n3_n4  : std_logic_vector(8 downto 0);
    signal sum_n5_n6  : std_logic_vector(8 downto 0);
    signal sum_last2  : std_logic_vector(8 downto 0);
    signal sum        : std_logic_vector(10 downto 0);

begin

    sum_first2 <= ('0' & nr1) + ('0' & nr2);
    sum_n3_n4  <= ('0' & nr3) + ('0' & nr4);
    sum_n5_n6  <= ('0' & nr5) + ('0' & nr6);
    sum_last2  <= ('0' & nr7) + ('0' & nr8);
    
    sum <= ('0' & (('0' & sum_first2) + ('0' & sum_n3_n4))) + ('0' & (('0' & sum_n5_n6) + ('0' & sum_last2)));
    
    avg <= sum(10 downto 3);
	
end arch_avg8;
