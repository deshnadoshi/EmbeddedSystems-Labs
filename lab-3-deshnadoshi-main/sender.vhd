----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:17:22 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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

entity sender is
  Port ( 
    rst, clk, en, btn, ready : in std_logic;
    send : out std_logic;
    char : out std_logic_vector(7 downto 0);
    debug_i : out std_logic_vector(2 downto 0) -- Debug signal for i -- DELETE L8R
  );
end sender;

architecture Behavioral of sender is

-- netid = dd1035 (need array of size = 6, length 12 bits)
type array_type is array(0 to 5) of std_logic_vector(7 downto 0); 
-- d = 100, 1 = 49, 0 = 48, 3 = 51, 5 = 53
signal netid : array_type := (
    "01100100",  -- "d"
    "01100100",  -- "d"
    "00110001",  -- "1"
    "00110000",  -- "0"
    "00110011",  -- "3"
    "00110101"   -- "5"
);
signal i : std_logic_vector(2 downto 0) := (others => '0'); -- for counting upto 6 digits
signal j : std_logic_vector(2 downto 0); -- for counting upto 5 elements in the array

type state_type is (idle, busyA, busyB, busyC);
signal state: state_type := idle; 


begin

process(clk, rst, state)
begin 

if (rising_edge(clk)) then 
    if (rst = '1') then 
        char <= (others => '0'); 
        send <= '0'; 
        i <= (others => '0');
        state <= idle; 
        
    elsif (en = '1') then 
        case state is 
            when idle =>
                if (ready = '1' and btn = '1') then 
                    -- store netid into char
                    if (to_integer(unsigned(i)) < 6) then 
                        send <= '1'; 
                        char <= netid(to_integer(unsigned(i)));
                        debug_i <= i; -- DELETE L8R
                        -- increase counter
                        i <= std_logic_vector(unsigned(i) + 1); 
                        state <= busyA; 
                    elsif (to_integer(unsigned(i)) = 6) then 
                        i <= (others => '0');
                        state <= idle; 
                    
                    end if; -- end unsgined i < 110
                end if; 
            when busyA =>
                state <= busyB; 
                
            when busyB =>
                send <= '0';
                state <= busyC; 
                
            when busyC => 
                if (ready = '1' and btn = '0') then
                    state <= idle; 
                else 
                    -- keep in bsuy C button 1
                    state <= busyC; 
                end if; 
            
            when others =>
                char <= (others => '0'); 
                send <= '0'; 
                i <= (others => '0');
                state <= idle; 
        end case; 
    
    end if; -- end rst
end if; -- end rising edge
end process; 


end Behavioral;
