
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
  Port ( 
    clk : in std_logic; 
    btn : in std_logic; --single bit input
    dbnc : out std_logic
    
  );
end debounce;

architecture Behavioral of debounce is

signal count : std_logic_vector(26 downto 0) := (others => '0'); 
signal shift_register :  std_logic_vector(1 downto 0) := (others => '0');


begin

    process(clk)
    begin
        if (rising_edge(clk)) then 
            if (btn = '1') then 
                if (unsigned(count) = 2499999) then 
                    dbnc <= '1';
                end if; 
                count <= std_logic_vector ( unsigned(count) + 1); 
            else
               count <= (others => '0'); 
               dbnc <= '0';
            end if; 
        end if; 
    
    end process; 


end Behavioral;


