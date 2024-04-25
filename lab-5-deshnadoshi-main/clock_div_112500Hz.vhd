
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div_112500Hz is
  Port ( 
    clk : in std_logic; 
    clk_enable : out std_logic
  );
end clock_div_112500Hz;

architecture Behavioral of clock_div_112500Hz is

signal count : std_logic_vector(11 downto 0) := (others => '0');
signal div_internal : std_logic := '0';

-- 125000000/115200 approx. 1085

begin
 

simple_clock : process(clk)

begin
if (rising_edge(clk)) then
    if( unsigned(count) = 1085) then 
        count <= (others => '0'); 
        div_internal <= '1';

    else
        count <= std_logic_vector ( unsigned(count) + 1); 
        div_internal <= '0';

    end if; 
    
end if; 

end process simple_clock; 
clk_enable <= div_internal; 



end Behavioral;