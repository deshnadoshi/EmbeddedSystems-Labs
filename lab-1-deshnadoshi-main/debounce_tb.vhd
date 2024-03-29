

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_STD.ALL;



entity debounce_tb is
end debounce_tb;

architecture testbench of debounce_tb is

signal tb_clk : std_logic := '0';
signal tb_btn : std_logic := '0'; 
signal tb_dbnc : std_logic; 
signal counter : std_logic_vector(26 downto 0) := (others => '0'); 

component debounce is 
    port (
        clk : in std_logic; 
        btn : in std_logic; 
        dbnc : out std_logic
        
    ); 
end component; 


begin

clk_gen_proc : process

begin 

        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
        
        counter <= std_logic_vector(unsigned(counter) + 1); 

        
end process clk_gen_proc;

btn_proc : process

begin 

    wait for 8 ns;
    tb_btn <= '1'; 
    
    
end process btn_proc; 


dut : debounce
port map (
    
    clk => tb_clk,
    btn => tb_btn,
    dbnc => tb_dbnc
    
);  

end testbench;