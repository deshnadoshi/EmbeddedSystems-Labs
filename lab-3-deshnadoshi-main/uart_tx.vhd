----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2024 11:01:07 PM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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

entity uart_tx is
  Port ( 
    clk, en, send, rst : in std_logic;
    char : in std_logic_vector(7 downto 0); 
    ready, tx : out std_logic
    --debug_counter : out std_logic_vector(2 downto 0) -- DELETE L8R
  
  );
end uart_tx;

architecture Behavioral of uart_tx is

type state_type is (idle, start, data);
signal state: state_type := idle; 

signal char_storage : std_logic_vector(7 downto 0) := (others => '0'); 
signal bit_counter : std_logic_vector(2 downto 0) := "000"; 

begin
process(clk)
    begin 
    if (rising_edge(clk)) then
        -- If rst = 1, internal reg = 0, goes into an idle state
        if (rst = '1') then
            ready <= '1';
            tx <= '1';
            bit_counter <= (others => '0');
            
        elsif (en = '1') then
            case state is
                when idle => 
                    ready <= '1';
                    tx <= '1';
                    
                    if send = '1' then
                        bit_counter <= (others => '0');
                        ready <= '0'; -- Starting trasmission, so it can't accept new data
                        tx <= '0'; -- Starting transmission, set to low
                        char_storage <= char; -- Store characters in a register
                        state <= start;
                    else 
                        ready <= '1';
                        tx <= '1'; 
                        state <= idle; 
                    end if;
                when start =>
                    -- start acts as a gateway to data, just need to make sure when it enters start, it passes to data
                    tx <= char_storage(0); 
                    -- get the first bit of the numbers to start the tx
                    bit_counter <= (others => '0');
                    -- RMR TO ADD 1
                    --bit_counter <= "001";
                    --debug_counter <= bit_counter;
                    state <= data; 
                    
                when data =>
                    if (unsigned(bit_counter)) < 7 then
                    
                        tx <= char_storage(to_integer(unsigned(bit_counter) + 1));
                            -- store the last bit into the tx output at each instance 
                            -- shift the number to the right by adding the counter and keep on getting the last bit
                        bit_counter <= std_logic_vector(unsigned(bit_counter) + 1);
                        --debug_counter <= bit_counter;
                            -- update the counter and keep the state still in data because it has to finish running for bits 0 to 7
                        state <= data;
                    else
                        tx <= '1'; -- Tranmission is finished, so line is high again
                        state <= idle;
                        bit_counter <= (others => '0'); 
                        ready <= '1'; 
                    end if;
                
                    
                when others =>
                    state <= idle;
            end case;
        end if;
        end if; -- rising edge clk

end process; 


end Behavioral;