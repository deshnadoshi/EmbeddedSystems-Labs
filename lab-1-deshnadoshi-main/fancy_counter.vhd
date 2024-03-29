library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity fancy_counter is
  port ( 
    
    clk : in std_logic;
    en : in std_logic;
    clk_en : in std_logic;
    rst : in std_logic; 
    ld : in std_logic;
    dir : in std_logic; 
    updn : in std_logic; 
    val : in std_logic_vector(3 downto 0); 
    
    cnt : out std_logic_vector(3 downto 0)
  
  );
end fancy_counter;

architecture Behavioral of fancy_counter is

signal direction_register : std_logic := '0';
signal value_register : std_logic_vector (3 downto 0) := "0000";
signal counter : std_logic_vector (3 downto 0) := (others => '0');



begin


    process(clk)
    begin 
    
        if (rising_edge(clk)) then 
            
            if (en = '1') then 
            
            if (ld = '1') then
                value_register <= val; 
            end if; 
            
            if (rst = '1') then
                counter <= "0000"; 
            end if;  
            
                if (clk_en = '1') then
                    
                    if (updn = '1') then 
                        direction_register <= dir; 
                    end if; 
                    
                    if (direction_register = '1') then 
                        if (counter = value_register) then
                            counter <= (others => '0');
                        else 
                            counter <= std_logic_vector(unsigned(counter) + 1);
                        end if;
                        
                    else 
                        if (counter = "0000") then
                            counter <= value_register;  
                        else 
                             counter <= std_logic_vector(unsigned(counter) - 1);
                        end if; 
                    end if; 
                end if;  
  
            end if;
            

        end if; 
    
    
    end process; 
    
    cnt <= counter; 


end Behavioral;