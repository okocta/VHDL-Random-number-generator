library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity frequency_divider is
    port (
        clk     : in std_logic;
        R       : in std_logic;
        clk_out : out std_logic
    );
end frequency_divider;

architecture arch_freq of frequency_divider is
    signal count : unsigned(25 downto 0) := (others => '0');
begin
    process (clk, R)
    begin
        if R = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;

    clk_out <= count(25);
end arch_freq;
