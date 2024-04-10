----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Deshna Doshi
-- 
-- Create Date: 03/28/2024 08:18:29 PM
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

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is


component vga_ctrl is 
  Port ( 
  clk, en : in std_logic;
  hcount, vcount : out std_logic_vector(9 downto 0); 
  vid, hs, vs : out std_logic
  );

end component; 


signal tb_clk, tb_en : std_logic := '0';
signal tb_hcount, tb_vcount : std_logic_vector(9 downto 0) := (others => '0');
signal tb_vid, tb_hs, tb_vs : std_logic := '0';


begin

clock_process : process
begin 
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';

end process clock_process;



--counter_process : process
--begin 

--    wait for 25 ns; 
--    tb_hcount <= std_logic_vector(unsigned(tb_hcount) + 1); 
--    tb_vcount <= std_logic_vector(unsigned(tb_vcount) + 1); 
    
--    wait for 5 ns; 

--end process counter_process; 

enable_process : process
begin 
    wait for 25 ns;
    tb_en <= '1'; 
    
    wait for 100 ns; 
    tb_en <= '0'; 
end process enable_process; 

dut : vga_ctrl 

    port map(
        clk => tb_clk, 
        en => tb_en, 
        hcount => tb_hcount,
        vcount => tb_vcount, 
        vid => tb_vid,
        hs => tb_hs,
        vs => tb_vs
    ); 
    



end Behavioral;
