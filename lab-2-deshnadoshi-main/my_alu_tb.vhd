library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu_tb is
--  Port ( );
end my_alu_tb;

architecture Behavioral of my_alu_tb is

signal opcode_tb :  std_logic_vector(3 downto 0);
signal A_tb : std_logic_vector(3 downto 0); 
signal B_tb:  std_logic_vector(3 downto 0);
signal output_tb : std_logic_vector(3 downto 0);
signal clk_tb : std_logic;

component my_alu is
  port ( 
  
    opcode : in std_logic_vector(3 downto 0); 
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    
    output : out std_logic_vector(3 downto 0)
      
  );
end component; 

begin

process_clk : process
begin 
    wait for 4 ns;
    clk_tb <= '1'; 
    
    wait for 4 ns; 
    clk_tb <= '0'; 

end process; 

alu_process : process
begin 
    
    -- test adding
    wait for 500 ns; 
    A_tb <= "0000";
    B_tb <= "0011";
    opcode_tb <= "0000"; 
    
    -- test subtraction
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "0001"; 
    
    -- test subtraction
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "0001"; 
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "0010";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "0011";
    
    wait for 500 ns; 
    A_tb <= "0110";
    B_tb <= "0001";
    opcode_tb <= "0100";
    
    wait for 500 ns; 
    A_tb <= "1001";
    B_tb <= "0001";
    opcode_tb <= "0101";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "1100";
    opcode_tb <= "0110";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "1001";
    opcode_tb <= "0111";
    
    wait for 500 ns; 
    A_tb <= "1011";
    B_tb <= "0111";
    opcode_tb <= "1000";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0011";
    opcode_tb <= "1001";

    wait for 500 ns; 
    A_tb <= "1111";
    B_tb <= "0001";
    opcode_tb <= "1010";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "1011";
    
    wait for 500 ns; 
    A_tb <= "1001";
    B_tb <= "0101";
    opcode_tb <= "1100";
    
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "1101";
    
    wait for 500 ns; 
    A_tb <= "0111";
    B_tb <= "0001";
    opcode_tb <= "1110";
    
        
    wait for 500 ns; 
    A_tb <= "0011";
    B_tb <= "0001";
    opcode_tb <= "1111";
    
end process; 

dut : my_alu 
port map(
    opcode => opcode_tb, 
    A => A_tb,
    B => B_tb,
    output => output_tb 

); 

end Behavioral;
