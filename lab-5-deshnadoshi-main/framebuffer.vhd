----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 08:40:53 AM
-- Design Name: 
-- Module Name: framebuffer - Behavioral
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

entity framebuffer is
  Port ( 
    clk1, en1, en2, ld : in std_logic; 
    addr1, addr2 : in std_logic_vector(11 downto 0);
    wr_en1 : in std_logic; 
    din1 : in std_logic_vector(15 downto 0);
    dout1, dout2 : out std_logic_vector(15 downto 0);
    rst : in std_logic
  
  );
end framebuffer;

architecture Behavioral of framebuffer is

type mem_type is array(0 to 4095) of std_logic_vector(15 downto 0); 
signal mem: mem_type := (others => (others => '0'));

begin

    process(clk1)
    begin 
    
        if (rising_edge(clk1)) then 
--            if (rst = '1') then 
--                dout1 <= (others => '0');
--                dout2 <= (others => '0'); 
--                mem <= (others => (others => '0'));
            
--            end if; 
            
            if (en1 = '1') then 
                if (wr_en1 = '1') then 
                    mem(to_integer(unsigned(addr1))) <= din1; 
                end if; -- wr_en = 1 end
                
                dout1 <= mem(to_integer(unsigned(addr1))); 
                
            end if; -- end en1 = 1        
        end if; --end rising edge clk1
    
    end process; 
    
    
    process(clk1)
    begin 
    
    if (rising_edge(clk1)) then 
        if (en2 = '1') then
            dout2 <= mem(to_integer(unsigned(addr2)));
        end if; -- end en2 = 1
        
    
    end if; -- end rising edge clk1
    
    end process; 
    

end Behavioral;