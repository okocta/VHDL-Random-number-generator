library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all; 

entity LCD_DISPLAY is
    port(CLK, RESET: in std_logic;
    DIN, AVG: in std_logic_vector(7 downto 0);
    ANODE: out std_logic_vector(3 downto 0);
    CATHODE: out std_logic_vector(6 downto 0));
end LCD_DISPLAY;

architecture arch of LCD_DISPLAY is		  

signal LED_BCD : std_logic_vector(3 downto 0);
signal led_count : std_logic_vector(1 downto 0); 

begin		  
	process(LED_BCD)
	begin
	    case LED_BCD is
		    when "0000" => CATHODE <= "0000001"; -- "0"     
		    when "0001" => CATHODE <= "1001111"; -- "1" 
		    when "0010" => CATHODE <= "0010010"; -- "2" 
		    when "0011" => CATHODE <= "0000110"; -- "3" 
		    when "0100" => CATHODE <= "1001100"; -- "4" 
		    when "0101" => CATHODE <= "0100100"; -- "5" 
		    when "0110" => CATHODE <= "0100000"; -- "6" 
		    when "0111" => CATHODE <= "0001111"; -- "7" 
		    when "1000" => CATHODE <= "0000000"; -- "8"     
		    when "1001" => CATHODE <= "0000100"; -- "9"
		    when "1010" => CATHODE <= "0001000"; -- "A"
		    when "1011" => CATHODE <= "1100000"; -- "B"
		    when "1100" => CATHODE <= "0110001"; -- "C"
		    when "1101" => CATHODE <= "1000010"; -- "D"
		    when "1110" => CATHODE <= "0110000"; -- "E"
		    when "1111" => CATHODE <= "0111000"; -- "F"
		    when others => CATHODE <= "1111111"; -- "LCD off"
	    end case;
	end process;
	
	process (CLK, RESET)	  
	variable divider : INTEGER := 0;
	begin
		if RESET = '1' then
			led_count <= "00"; 
		else
			if (CLK'EVENT and CLK = '1') then
		    	divider := divider + 1;
		    	if (divider = 10000) then
					led_count <= led_count + 1;
					divider := 0;	
				end if;
			end if;
		end if;
	end process; 
	
	process (led_count, DIN, AVG)
	begin
		case led_count is
		    when "00" =>
		        LED_BCD <= DIN(7 downto 4);
		        ANODE <= "0111";
		    when "01" =>
		        LED_BCD <= DIN(3 downto 0);
		        ANODE <= "1011";
		    when "10" =>
		        LED_BCD <= AVG(7 downto 4);
		        ANODE <= "1101";
		    when "11" =>
		        LED_BCD <= AVG(3 downto 0);
		        ANODE <= "1110";
		    when others =>
		         ANODE <="1111";
		 end case;
	end process;
end arch;
