
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_top is
  port ( 
    
    div_top_clk : in std_logic;
    led0 : out std_logic 
  
  );
end divider_top;

architecture Behavioral of divider_top is

component clock_div is 
    port (
        clk : in std_logic; 
        clk_enable : out std_logic
        
    ); 
end component; 

--signal div_top_clk : std_logic := '0';
signal div_top_enable : std_logic := '0'; 

signal led_0_sig : std_logic;


begin

   process(div_top_clk)
    begin
    if (rising_edge(div_top_clk)) then
        if (div_top_enable = '1') then
            led_0_sig <= NOT led_0_sig; 
        end if; 
    end if; 
       
   end process;

led0 <= led_0_sig; 

dut : clock_div
port map (
    
    clk => div_top_clk,
    clk_enable => div_top_enable
    
);  

end Behavioral;