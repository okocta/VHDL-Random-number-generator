library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
    port (
        x, y : in std_logic;
        z : out std_logic
    );
end xor_gate;

architecture arch_xor of xor_gate is
begin
    z <= x xor y;
end arch_xor;