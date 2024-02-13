library ieee;
use ieee.std_logic_1164.all;

entity lfsr_8bit is
  port(
    CLK   : in  std_logic;
    RESET : in  std_logic;
    Q     : out std_logic_vector(7 downto 0)
  );
end entity lfsr_8bit;

architecture arch_lfsr8 of lfsr_8bit is
  component xor_gate is
    port (
      x : in  std_logic;
      y : in  std_logic;
      z : out std_logic
    );
  end component xor_gate;

  signal iQ    : std_logic_vector(7 downto 0);
  signal xor1  : std_logic;
  signal xor2  : std_logic;
  signal xor3  : std_logic;

begin
  process(CLK, RESET)
  begin
    if (RESET = '1') then
      iQ <= (others => '1');
    elsif rising_edge(CLK) then
      xor1 <= iQ(1) xor iQ(5);
      xor2 <= iQ(6) xor iQ(7);
      xor3 <= xor1 xor xor2;
      iQ(7 downto 1) <= iQ(6 downto 0);
      iQ(0) <= xor3;
    end if;
  end process;

  Q <= iQ;

end architecture arch_lfsr8;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity xor_gate is

	port (x, y: in STD_LOGIC;
	z: out STD_LOGIC);
	
end xor_gate;

architecture arch_xor of xor_gate is
begin

	process(x, y)
	
	begin
	
		z<= x xor y;
	end process;
	
end arch_xor;









