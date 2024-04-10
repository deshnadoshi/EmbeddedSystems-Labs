
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
  Port ( 
    clk : in std_logic; 
    clk_enable : out std_logic
  );
end clock_div;

architecture Behavioral of clock_div is

signal count : std_logic_vector(26 downto 0) := (others => '0');
signal enable_out_internal : std_logic := '0';


begin
 

simple_clock : process(clk)

begin
if (rising_edge(clk)) then
    if(unsigned(count) = 5) then 
        count <= (others => '0'); 
        enable_out_internal <= '1';


    else
        count <= std_logic_vector (unsigned(count) + 1); 
        enable_out_internal <= '0';
        
    end if; 
    
end if; 

end process simple_clock; 
clk_enable <= enable_out_internal; 



end Behavioral;