library ieee;
use ieee.std_logic_1164.all;

entity lfsr_4bit is
    port (
        CLK   : in  std_logic;
        Q     : out std_logic_vector(3 downto 0);
        RESET : in  std_logic
    );
end lfsr_4bit;

architecture arch_lfsr4 of lfsr_4bit is
    

    component xor_gate is
        port (
            x : in  std_logic;
            y : in  std_logic;
            z : out std_logic
        );
    end component;

    signal iQ      : std_logic_vector(3 downto 0) := "1111";
    signal rez_xor : std_logic;

begin
    l0: xor_gate port map (iQ(2), iQ(3), rez_xor);
    
    process (CLK, RESET)
    begin
        if RESET = '1' then
            iQ <= "1111";
        elsif rising_edge(CLK) then
            iQ(0) <= rez_xor;
            iQ(1) <= iQ(0);
            iQ(2) <= iQ(1);
            iQ(3) <= iQ(2);
        end if;
    end process;

    Q <= iQ;

end arch_lfsr4;




library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor_gate is

	port (x, y: in STD_LOGIC;
	z: out STD_LOGIC);
	
end xor_gate;

architecture arch of xor_gate is
begin

	process(x, y)
	
	begin
	
		z<= x xor y;
	end process;
	
end arch;

