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
        clk   : in std_logic; 
        btn   : in std_logic; -- single bit input
        dbnc  : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
     -- 20ms debounce time
    signal shift_register  : std_logic_vector(1 downto 0) := (others => '0');
    signal debounce_count : integer := 0;
    signal debounced_value : std_logic := '0';

begin
    process(clk)
    begin
        if (rising_edge(clk)) then 
            shift_register(0) <= btn;
            shift_register(1) <= shift_register(0);

            if (shift_register(1) = '1') then
                if debounce_count < 2500000 then
                    debounce_count <= debounce_count + 1;
                end if;
            else
                debounce_count <= 0;
            end if;

            if debounce_count >= 2500000 then
                debounced_value <= '1';
            else
                debounced_value <= '0';
            end if;
        end if; 
    end process; 
    
    dbnc <= debounced_value;

end Behavioral;