library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DATA_GENERATOR_BLOCK is
	port(CLK, RESET: in std_logic;
		CONTROL: in std_logic_vector(2 downto 0);
		DATA: out std_logic_vector(7 downto 0));
end DATA_GENERATOR_BLOCK;

architecture arch of DATA_GENERATOR_BLOCK is

component LFSR_4BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component LFSR_8BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal Q4: std_logic_vector(3 downto 0);
signal Q8: std_logic_vector(7 downto 0);
begin			 
	C0: LFSR_4BIT port map(CLK, RESET, Q4);
	C1: LFSR_8Bit port map(CLK, RESET, Q8);
	process (RESET, Q4, Q8, CONTROL)
	variable iDATA: std_logic_vector(7 downto 0) := "00000000";
	begin
		if (RESET = '1') then 
			iData := "00000000";		
		else
			case CONTROL is
				when "000" => iDATA := "00000000";
				when "010" => iDATA := "00111111";
				when "011" => iDATA := "00111101";
				when "110" => iDATA := "0000" & Q4;
				when others => iDATA := Q8;
			end case;
		end if;
		DATA <= iDATA;
	end process;
end arch;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LFSR_4BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(3 downto 0));
end LFSR_4BIT;

architecture arch of LFSR_4BIT is 



component D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end component;

component XOR_GATE is					   	
	port(A, B: in STD_LOGIC;
		Y: out STD_LOGIC);
end component;
signal Qout: STD_LOGIC_VECTOR(3 downto 0):="0000"; 
signal s1: STD_LOGIC; 

begin

	C0: XOR_GATE port map(Qout(2), Qout(3), s1);
	C1: D_FF port map(s1, CLK, RESET, Qout(0));
	C2: D_FF port map(Qout(0), CLK, RESET, Qout(1));
	C3: D_FF port map(Qout(1), CLK, RESET, Qout(2));
	C4: D_FF port map(Qout(2), CLK, RESET, Qout(3));  	  
	Q <= Qout;
end arch;


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end D_FF;

architecture arch of D_FF is
begin
	process (CLK, RESET) 
	variable iQ: std_logic := '1';
	begin
		if RESET = '1' then
			iQ := '1';
		else
			if (CLK'event and CLK = '1')
				then iQ := D;
			end if;	
		end if;
		Q <= iQ;
	end process;
end arch;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity XOR_GATE is
	port (A, B: in STD_LOGIC;
	Y: out STD_LOGIC);
end XOR_GATE;

architecture arch of XOR_GATE is
begin
	process(A, B)
	begin
		Y <= A xor B;
	end process;
end arch;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LFSR_8BIT is
	port(CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC_VECTOR(7 downto 0));
end LFSR_8BIT;

architecture arch of LFSR_8BIT is 

signal Qout: STD_LOGIC_VECTOR(7 downto 0); --numarul generat
signal s1: STD_LOGIC;
signal s2: STD_LOGIC;
signal s3: STD_LOGIC;

component D_FF is 
	port(D, CLK: in STD_LOGIC;
		RESET: in STD_LOGIC;
		Q: out STD_LOGIC);
end component;

component XOR_GATE is
	port(A, B: in STD_LOGIC;
		Y: out STD_LOGIC);
end component;

begin
	C0: XOR_GATE port map(Qout(1), Qout(5), s1);
	C1: XOR_GATE port map(Qout(6), Qout(7), s2);
	C2: XOR_GATE port map(s1, s2, s3);
	C3: D_FF port map(s3, CLK, RESET, Qout(0));
	C4: D_FF port map(Qout(0), CLK, RESET, Qout(1));
	C5: D_FF port map(Qout(1), CLK, RESET, Qout(2));
	C6: D_FF port map(Qout(2), CLK, RESET, Qout(3));
	C7: D_FF port map(Qout(3), CLK, RESET, Qout(4));
	C8: D_FF port map(Qout(4), CLK, RESET, Qout(5));
	C9: D_FF port map(Qout(5), CLK, RESET, Qout(6));
	C10: D_FF port map(Qout(6), CLK, RESET, Qout(7));
	Q <= Qout;
end arch;










