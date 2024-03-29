----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 01:59:30 PM
-- Design Name: 
-- Module Name: uart_top_tb - Behavioral
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

entity uart_top_tb is
--  Port ( );
end uart_top_tb;

architecture Behavioral of uart_top_tb is


component uart_top is
    port (
        TXD, clk : in std_logic; 
        btn : in std_logic_vector(1 downto 0); 
        CTS, RTS, RXD : out std_logic

    ); 
end component; 

signal tb_clk : std_logic := '0'; 
signal tb_btn : std_logic_vector(1 downto 0) := (others => '0'); 
signal tb_TXD : std_logic := '0'; 

signal tb_CTS, tb_RTS, tb_RXD : std_logic := '0'; 

begin

clk_gen_proc : process
begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';

end process clk_gen_proc;

txd_gen_proc : process
begin 
        tb_btn(0) <= '1';
        wait for 10 ms;
        tb_btn(0) <= '0';


        --for i in 0 to 6 loop
            tb_btn(0) <= '0'; 
            tb_btn(1) <= '1';  
            
            wait for 25 ms;
            tb_btn(0) <= '0';
            tb_btn(1) <= '0';  
            
            wait for 40 ms;
            
        --end loop;

end process txd_gen_proc; 



dut : uart_top
    port map (
        TXD => tb_TXD,
        clk => tb_clk,
        btn => tb_btn,
        RXD => tb_RXD
    ); 


end Behavioral;