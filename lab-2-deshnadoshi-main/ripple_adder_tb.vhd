-- UNFINISHED
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder_tb is
--  Port ( );
end ripple_adder_tb;

architecture testbench of ripple_adder_tb is

signal tb_clk : std_logic := '0';
signal A_tb : std_logic_vector(3 downto 0);
signal B_tb : std_logic_vector(3 downto 0);
signal Cout_tb : std_logic; 
signal Cin_tb : std_logic; 
signal S_tb : std_logic_vector(3 downto 0); 


component ripple_adder is 

port (
    C0 : in std_logic;
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0); 
    
    C4 : out std_logic; 
    S : out std_logic_vector(3 downto 0) 
); 

end component; 

begin

clk_process : process

begin 
    wait for 4 ns;
    tb_clk <= '1'; 
    
    wait for 4 ns; 
    tb_clk <= '0'; 

end process; 


adder_process: process
begin 
    wait for 500 ns; 
    A_tb <= "1000";
    B_tb <= "0011";
    Cin_tb <= '0'; 
 
    
    wait for 500 ns;
    A_tb <= "0000";
    B_tb <= "0110"; 
    Cin_tb <= '1'; 

    wait for 500 ns; 
    A_tb <= "0110";
    B_tb <= "1000"; 
    Cin_tb <= '0'; 


    wait for 500 ns; 
    A_tb <= "0001";
    B_tb <= "0000"; 
    Cin_tb <= '1'; 
    
    wait for 500 ns; 
    A_tb <= "1111";
    B_tb <= "1111"; 
    Cin_tb <= '1'; 

    

    
end process; 


dut : ripple_adder 
port map(
    C0 => Cin_tb, 
    A => A_tb,
    B => B_tb,
    C4 => Cout_tb,
    S  => S_tb

); 


end testbench;
