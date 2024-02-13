library ieee;
use ieee.std_logic_1164.all;

entity data_generator_block is
    port (
        CONTROL : in  std_logic_vector(1 downto 0);
        CLK     : in  std_logic;
        RESET   : in  std_logic;
        Data    : out std_logic_vector(7 downto 0)
    );
end entity data_generator_block;

architecture arch_data of data_generator_block is

    component lfsr_8bit is
        port (
            CLK   : in  std_logic;
            RESET : in  std_logic;
            Q     : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component lfsr_4bit is
        port (
            CLK   : in  std_logic;
            Q     : out std_logic_vector(3 downto 0);
            RESET : in  std_logic
        );
    end component;

    signal iQ4  : std_logic_vector(3 downto 0);
    signal iQ8  : std_logic_vector(7 downto 0);
    signal iData: std_logic_vector(7 downto 0) := (others => '0');
    
begin

    C0: lfsr_4bit port map (CLK, iQ4, RESET);
    C1: lfsr_8bit port map (CLK, RESET, iQ8);
    
    process (RESET, iQ4, iQ8, CONTROL)
    begin
        if RESET = '1' then 
            iData <= (others => '0');
        else
            case CONTROL is
                when "10" =>
                    iData <= "10101010";
                when "11" =>
                    iData <= "00110011";
                when "01" =>
                    iData <= "0000" & iQ4;
                when others =>
                    iData <= iQ8;
            end case;
        end if;
    end process;

    Data <= iData;
    
end architecture arch_data;


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





















































