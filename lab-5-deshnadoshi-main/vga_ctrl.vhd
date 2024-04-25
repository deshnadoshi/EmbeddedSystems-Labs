----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Deshna Doshi
-- 
-- Create Date: 03/28/2024 07:52:37 PM
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
  Port ( 
  clk, en : in std_logic;
  hcount, vcount : out std_logic_vector(9 downto 0); 
  vid, hs, vs : out std_logic
  );
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal hcount_storage : std_logic_vector(9 downto 0) := (others => '0'); 
signal vcount_storage : std_logic_vector(9 downto 0) := (others => '0'); 

begin

    hcount <= hcount_storage; 
    vcount <= vcount_storage; 
    
    process(clk)
    begin 
        if (rising_edge(clk)) then 

            if (en = '1') then 
                -- 0 to 63 for hcount and 0 to 63 for vcount
                if (unsigned(hcount_storage) < 799) then 
                    hcount_storage <= std_logic_vector(unsigned(hcount_storage) + 1); 

                else
                    hcount_storage <= (others => '0'); 
                    
                    if (unsigned(vcount_storage) < 524) then 
                        vcount_storage <= std_logic_vector(unsigned(vcount_storage) + 1);
                    else 
                        vcount_storage <= (others => '0'); 
                    end if; -- vcount end if 

                end if; -- hcount endif
                
                                
                
                
            end if; -- en endif
            
            
        
        end if; -- rising edge end if
        
    
    end process; 
    
    process (hcount_storage, vcount_storage)
    begin 
    
                    -- display should be on with these conditions
--                if (unsigned(hcount_storage) <= 639) and (unsigned(hcount_storage) >= 0) then 
--                    if ((unsigned(vcount_storage) <= 479) and (unsigned(vcount_storage) >= 0)) then 
--                        vid <= '1';
--                    end if; -- vcount condition 
--                else 
--                       vid <= '0'; 
--                end if; -- end display conditions
                
                if ((unsigned(hcount_storage) <= 64) and (unsigned(hcount_storage) >= 0)) and ((unsigned(vcount_storage) <= 64) and (unsigned(vcount_storage) >= 0)) then 
                    vid <= '1'; 
                else 
                    vid <= '0';
                end if; 
                
                if (unsigned(hcount_storage) >= 656) and (unsigned(hcount_storage) <= 751) then 
                    hs <= '0'; 
                else 
                    hs <= '1'; 
                end if; -- end hs condition
                
                
                if (unsigned(vcount_storage) >= 490) and (unsigned(vcount_storage) <= 491) then 
                    vs <= '0';
                else 
                    vs <= '1'; 
                end if; -- end vs condition

    
    
    end process;     
   

end Behavioral;