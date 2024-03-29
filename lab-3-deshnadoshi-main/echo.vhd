----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2024 07:09:33 PM
-- Design Name: 
-- Module Name: echo - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity echo is
  Port ( 
    clk, en, ready, newChar : in std_logic;
    charIn : in std_logic_vector(7 downto 0);
    send : out std_logic;
    charOut : out std_logic_vector(7 downto 0)
  
  );
end echo;

architecture Behavioral of echo is

type state_type is (idle, busyA, busyB, busyC);
signal state: state_type := idle; 

begin
    process (clk) 
    begin 
        if (rising_edge(clk) and en = '1') then 
        
            case state is 
                when idle =>
                    if newChar = '1' then 
                        send <= '1';
                        charOut <= charIn; 
                        state <= busyA; 
                        
                    end if; 
                    
                when busyA =>
                    state <= busyB; 
                
                when busyB =>
                    send <= '0';
                    state <= busyC;
                when busyC =>
                    if (ready = '1') then 
                        state <= idle; 
                    else 
                        state <= busyC;
                    end if; 
                when others =>
                    state <= idle; 
            
            end case; 
        
        
        end if; 
        
    end process; 


end Behavioral;
