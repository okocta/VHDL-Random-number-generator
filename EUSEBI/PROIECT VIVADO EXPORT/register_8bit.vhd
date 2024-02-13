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
