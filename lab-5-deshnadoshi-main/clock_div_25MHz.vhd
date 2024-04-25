
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div_25MHz is
  Port ( 
    clk : in std_logic; 
    clk_enable : out std_logic
  );
end clock_div_25MHz;

architecture Behavioral of clock_div_25MHz is

signal count : std_logic_vector(26 downto 0) := (others => '0');
signal enable_out_internal : std_logic := '0';


begin
 

simple_clock : process(clk)

begin
if (rising_edge(clk)) then
        count <= std_logic_vector (unsigned(count) + 1); 

    if(unsigned(count) = 4) then 
        count <= (others => '0'); 
        enable_out_internal <= '1';


    else
        enable_out_internal <= '0';
        
    end if; 
    
end if; 

end process simple_clock; 
clk_enable <= enable_out_internal; 



end Behavioral;