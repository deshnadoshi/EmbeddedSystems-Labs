----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 08:22:01 AM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity pixel_pusher is
  Port ( 
    clk, en : in std_logic;
    vs, vid : in std_logic;
    pixel : in std_logic_vector(15 downto 0); -- 16 bit pixel
    hcount : in std_logic_vector(9 downto 0);
    R, B : out std_logic_vector(4 downto 0);
    G : out std_logic_vector(5 downto 0); 
    addr : out std_logic_vector(11 downto 0)
  
  );
end pixel_pusher;

architecture Behavioral of pixel_pusher is
-- using a 12 bit adder
signal addr_counter : std_logic_vector(11 downto 0) := (others => '0'); 

begin
    addr <= addr_counter;
    
    process(clk)
    begin
    
    if (rising_edge(clk)) then 
    
        --if (en = '1') then 
          
            if (en = '1') and (vid = '1') and (unsigned(hcount) < 480) then 
                R <= pixel( 7 downto 5 ) & "00";
                G <= pixel( 4 downto 2 ) & "000";
                B <= pixel( 1 downto 0 ) & "000";
                
                addr_counter <= std_logic_vector(unsigned(addr_counter) + 1); 

            else 
                R <= (others => '0');
                G <= (others => '0');
                B <= (others => '0');
                -- addr_counter <= (others => '0');
            end if; -- vid = 1 and hcount < 480
        
        --end if; -- en = 1
        
        if vs = '0' then 
            addr_counter <= (others => '0'); 
        end if; 
    
    end if; -- end rising edge clk
    
    
    end process; 


end Behavioral;
