library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity average_16numbers is
    port (
        nr1  : in std_logic_vector(7 downto 0);
        nr2  : in std_logic_vector(7 downto 0);
        nr3  : in std_logic_vector(7 downto 0);
        nr4  : in std_logic_vector(7 downto 0);
        nr5  : in std_logic_vector(7 downto 0);
        nr6  : in std_logic_vector(7 downto 0);
        nr7  : in std_logic_vector(7 downto 0);
        nr8  : in std_logic_vector(7 downto 0);
        nr9  : in std_logic_vector(7 downto 0);
        nr10 : in std_logic_vector(7 downto 0);
        nr11 : in std_logic_vector(7 downto 0);
        nr12 : in std_logic_vector(7 downto 0);
        nr13 : in std_logic_vector(7 downto 0);
        nr14 : in std_logic_vector(7 downto 0);
        nr15 : in std_logic_vector(7 downto 0);
        nr16 : in std_logic_vector(7 downto 0);
        avg  : out std_logic_vector(7 downto 0)
    );
end average_16numbers;

architecture arch_avg16 of average_16numbers is

    signal sum_nr1_nr2   : std_logic_vector(8 downto 0);
    signal sum_nr3_nr4   : std_logic_vector(8 downto 0);
    signal sum_nr5_nr6   : std_logic_vector(8 downto 0);
    signal sum_nr7_nr8   : std_logic_vector(8 downto 0);
    signal sum_nr9_nr10  : std_logic_vector(8 downto 0);
    signal sum_nr11_nr12 : std_logic_vector(8 downto 0);
    signal sum_nr13_nr14 : std_logic_vector(8 downto 0);
    signal sum_nr15_nr16 : std_logic_vector(8 downto 0);
    signal sum1_4        : std_logic_vector(9 downto 0);
    signal sum5_8        : std_logic_vector(9 downto 0);
    signal sum9_12       : std_logic_vector(9 downto 0);
    signal sum13_16      : std_logic_vector(9 downto 0);
    signal sum           : std_logic_vector(11 downto 0);

begin

    sum_nr1_nr2   <= ('0' & nr1)  + ('0' & nr2);
    sum_nr3_nr4   <= ('0' & nr3)  + ('0' & nr4);
    sum_nr5_nr6   <= ('0' & nr5)  + ('0' & nr6);
    sum_nr7_nr8   <= ('0' & nr7)  + ('0' & nr8);
    sum_nr9_nr10  <= ('0' & nr9)  + ('0' & nr10);
    sum_nr11_nr12 <= ('0' & nr11) + ('0' & nr12);
    sum_nr13_nr14 <= ('0' & nr13) + ('0' & nr14);
    sum_nr15_nr16 <= ('0' & nr15) + ('0' & nr16);
    
    sum1_4  <= ('0' & sum_nr1_nr2)   + ('0' & sum_nr3_nr4);
    sum5_8  <= ('0' & sum_nr5_nr6)   + ('0' & sum_nr7_nr8);
    sum9_12 <= ('0' & sum_nr9_nr10)  + ('0' & sum_nr11_nr12);
    sum13_16 <= ('0' & sum_nr13_nr14) + ('0' & sum_nr15_nr16);
    
    sum <= ('0' & (('0' & sum1_4) + ('0' & sum5_8))) + ('0' & (('0' & sum9_12) + ('0' & sum13_16)));
    
    avg <= sum(11 downto 4);
	
end arch_avg16;
