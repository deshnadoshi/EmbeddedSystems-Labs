----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Deshna Doshi
-- 
-- Create Date: 03/30/2024 10:44:14 AM
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

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is

-- need components for image top only
component image_top is
  Port ( 
    clk : in std_logic; 
    vga_hs, vga_vs : out std_logic;
    vga_r, vga_b : out std_logic_vector(4 downto 0);
    vga_g : out std_logic_vector(5 downto 0)
    
  );
end component;

signal tb_clk : std_logic := '0';
signal tb_vga_hs, tb_vga_vs : std_logic := '0';
signal tb_vga_r, tb_vga_b : std_logic_vector(4 downto 0) := (others => '0');
signal tb_vga_g : std_logic_vector(5 downto 0); 

begin

clock_process : process
begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';

end process clock_process;


dut : image_top
port map (

    clk => tb_clk, 
    vga_hs => tb_vga_hs, 
    vga_vs => tb_vga_vs,
    vga_r => tb_vga_r, 
    vga_g => tb_vga_g,
    vga_b => tb_vga_b

); 


end Behavioral;

