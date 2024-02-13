library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity squarewave_generator is
    port (
        clk: in std_logic;
        R: in std_logic;
        clk_out: out std_logic
    );
end squarewave_generator;

architecture arch_square of squarewave_generator is
    signal count: unsigned(1 downto 0) := "00";
begin
    process(clk, R)
    begin
        if R = '1' then
            count <= "00";
        elsif rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;

    clk_out <= count(1);
end arch_square;
