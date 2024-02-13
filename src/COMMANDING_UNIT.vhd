library IEEE;
use IEEE.std_logic_1164.all;

entity COMMANDING_UNIT is
	port(SYSTEM_CLK: in std_logic;	 
	RESET: in std_logic;
	CONTROL: in std_logic_vector(2 downto 0);
	FILTER: in std_logic_vector(2 downto 0);
	CATHODE: out std_logic_vector(6 downto 0);
	ANODE: out std_logic_vector(3 downto 0));
end COMMANDING_UNIT;

architecture arch of COMMANDING_UNIT is

signal CLK_1HZ : std_logic;
signal CLK_SQUARE_WAVE : std_logic;
signal CLK : std_logic;
signal DIN : std_logic_vector(7 downto 0);
signal AVG : std_logic_vector(7 downto 0);

component FREQUENCY_DIVIDER is
	port(CLK_IN: in std_logic;
	RESET: in std_logic;
	CLK_OUT: out std_logic);
end component; 

component DATA_GENERATOR_BLOCK is
	port(CLK: in std_logic;
	RESET: in std_logic;
	CONTROL: in std_logic_vector(2 downto 0);	
	DATA: out std_logic_vector(7 downto 0));
end component;

component AVERAGE_COMPUTER_BLOCK is
	port(DIN: in std_logic_vector(7 downto 0);
	CLK: in std_logic;
	FILTER: in std_logic_vector(2 downto 0);  
	RESET: in std_logic;
	AVERAGE: out std_logic_vector(7 downto 0));
end component; 	

component LCD_DISPLAY is
    port(CLK, RESET: in std_logic;
    DIN, AVG: in std_logic_vector(7 downto 0);
    ANODE: out std_logic_vector(3 downto 0);
    CATHODE: out std_logic_vector(6 downto 0));
end component;

component SQUARE_WAVE_GENERATOR is
	port(CLK_IN: in std_logic;
	RESET: in std_logic;
	CLK_OUT: out std_logic);
end component;

begin
	  L1: FREQUENCY_DIVIDER port map(SYSTEM_CLK, RESET, CLK_1HZ);
	  L2: DATA_GENERATOR_BLOCK port map(CLK, RESET, CONTROL, DIN);
	  L3: AVERAGE_COMPUTER_BLOCK port map(DIN, CLK, FILTER, RESET, AVG);
	  L4: LCD_DISPLAY port map(SYSTEM_CLK, RESET, DIN, AVG, ANODE, CATHODE); 
	  L5: SQUARE_WAVE_GENERATOR port map(CLK_1HZ, RESET, CLK_SQUARE_WAVE);
	  process(FILTER)
	  begin
		  if FILTER = "001" then
			  CLK <= CLK_1HZ;
		  else
			  CLK <= CLK_SQUARE_WAVE;
		  end if;
	  end process;
end arch;