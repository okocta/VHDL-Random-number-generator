library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity average_computer_block is
    port (
        DIN: in std_logic_vector(7 downto 0);
        CLK: in std_logic;
        FILTER: in std_logic_vector(2 downto 0);
        RESET: in std_logic;
        AVERAGE: out std_logic_vector(7 downto 0)
    );
end average_computer_block;

architecture arch_avg of average_computer_block is

    component average_16numbers is
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
    end component;

    component average_2numbers is
        port (
            nr1: in std_logic_vector(7 downto 0);
            nr2: in std_logic_vector(7 downto 0);
            average: out std_logic_vector(7 downto 0)
        );
    end component;

    component average_4numbers is
        port (
            nr1: in std_logic_vector(7 downto 0);
            nr2: in std_logic_vector(7 downto 0);
            nr3: in std_logic_vector(7 downto 0);
            nr4: in std_logic_vector(7 downto 0);
            avg: out std_logic_vector(7 downto 0)
        );
    end component;

    component register_8bit is
        port (
            din: in std_logic_vector(7 downto 0);
            r: in std_logic;
            clk: in std_logic;
            q: out std_logic_vector(7 downto 0)
        );
    end component;

    component average_8numbers is
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
            L2: register_8bit port map (DIN, RESET, CLK, NUM(0));
        end generate;

        L3: if I > 0 generate
            L3: register_8bit port map (NUM(I - 1), RESET, CLK, NUM(I));
        end generate;
    end generate;

    AVG_OF_LAST2: average_2numbers port map (NUM(0), NUM(1), AVERAGE_LAST2);
    AVG_OF_LAST4: average_4numbers port map (NUM(0), NUM(1), NUM(2), NUM(3), AVERAGE_LAST4);
    AVG_OF_LAST8: average_8numbers port map (NUM(0), NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), NUM(6), NUM(7), AVERAGE_LAST8);
    AVG_OF_LAST16: average_16numbers port map (NUM(0), NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), NUM(6), NUM(7),NUM(8), NUM(9), NUM(10), NUM(11), NUM(12), NUM(13), NUM(14), NUM(15), AVERAGE_LAST16);

    process (FILTER, AVERAGE_LAST2, AVERAGE_LAST4, AVERAGE_LAST8, AVERAGE_LAST16)
        variable AVG: std_logic_vector(7 downto 0) := "00000000";
    begin
        case FILTER is
            when "100" =>
                AVG := AVERAGE_LAST2;
            when "101" =>
                AVG := AVERAGE_LAST4;
            when "110" =>
                AVG := AVERAGE_LAST8;
            when "111" =>
                AVG := AVERAGE_LAST16;
            when others =>
                null;
        end case;

        AVERAGE <= AVG;
    end process;

end arch_avg;

library ieee;
use ieee.std_logic_1164.all;

entity register_8bit is
    port (
        din : in std_logic_vector(7 downto 0);
        r   : in std_logic;
        clk : in std_logic;
        q   : out std_logic_vector(7 downto 0)
    );
end entity register_8bit;

architecture arch_registru of register_8bit is
    signal idin : std_logic_vector(7 downto 0) := (others => '0');
begin
    process (r, clk)
    begin
        if r = '1' then
            idin <= (others => '0');
        elsif rising_edge(clk) then
            idin <= din;
        end if;
    end process;

    q <= idin;
end architecture arch_registru;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity average_2numbers is
    port (
        nr1     : in  std_logic_vector(7 downto 0);
        nr2     : in  std_logic_vector(7 downto 0);
        average : out std_logic_vector(7 downto 0)
    );
end entity average_2numbers;

architecture arch_avg2 of average_2numbers is
    signal SUM : std_logic_vector(8 downto 0) := (others => '0');
begin 
    SUM <= ('0' & nr1) + ('0' & nr2);
    average <= SUM(8 downto 1);
end architecture arch_avg2;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity average_4numbers is
    port (
        nr1 : in std_logic_vector(7 downto 0);
        nr2 : in std_logic_vector(7 downto 0);
        nr3 : in std_logic_vector(7 downto 0);
        nr4 : in std_logic_vector(7 downto 0);
        avg : out std_logic_vector(7 downto 0)
    );
end average_4numbers;

architecture arch_avg4 of average_4numbers is  
    signal first2_sum : std_logic_vector(8 downto 0);
    signal last2_sum  : std_logic_vector(8 downto 0);
    signal sum        : std_logic_vector(9 downto 0);
begin
    first2_sum <= ('0' & nr1) + ('0' & nr2);
    last2_sum  <= ('0' & nr3) + ('0' & nr4);
    sum        <= ('0' & first2_sum) + ('0' & last2_sum);
    avg        <= sum(9 downto 2);
end arch_avg4;

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







	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	








	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

		
	