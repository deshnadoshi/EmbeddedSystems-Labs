----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2024 07:19:41 AM
-- Design Name: 
-- Module Name: sender_tb - Behavioral
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

entity sender_tb is
--  Port ( );
end sender_tb;

architecture Behavioral of sender_tb is


component sender is
  Port ( 
    rst, clk, en, btn, ready : in std_logic;
    send : out std_logic;
    char : out std_logic_vector(7 downto 0);
    debug_i : out std_logic_vector(2 downto 0) -- DELETE L8R
  
  );
end component;

signal tb_rst, tb_clk, tb_en, tb_btn, tb_ready : std_logic := '0'; 
signal tb_send : std_logic := '0';
signal tb_char : std_logic_vector(7 downto 0) := (others => '0'); 
signal tb_debug_i : std_logic_vector(2 downto 0); --DELETE L8R

begin

clk_gen_proc : process
begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';

end process clk_gen_proc;

ready_en_proc : process
begin 
        tb_rst <= '1';
        wait for 10 ns;
        tb_rst <= '0';

        tb_en <= '1';

        for i in 0 to 6 loop
            tb_btn <= '1';  
            tb_ready <= '1';  -- making ready signal high to start processsing
            
            wait for 20 ns;
            tb_btn <= '0';  -- make btn 0 to get it to switch
            tb_ready <= '1';  -- keep ready at high
            
            wait for 40 ns;
            
        end loop;


end process ready_en_proc;


dut: sender port map (
    rst => tb_rst,
    clk => tb_clk,
    en => tb_en,
    btn => tb_btn,
    ready => tb_ready,
    send => tb_send,
    char => tb_char,
    debug_i => tb_debug_i -- DELETE L8R
);


end Behavioral;
