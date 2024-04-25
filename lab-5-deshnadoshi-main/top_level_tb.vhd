----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2024 07:27:16 PM
-- Design Name: 
-- Module Name: top_level_tb - Behavioral
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

entity top_level_tb is
--  Port ( );
end top_level_tb;


architecture Behavioral of top_level_tb is

    component uproc_top_level_wrapper
        port (
            clk : in STD_LOGIC;
            
            CTS : out STD_LOGIC;
            RTS : out STD_LOGIC;
            RXD : out STD_LOGIC;
            TXD : in STD_LOGIC;
            
            btn_0 : in STD_LOGIC;
            
            vga_r : out STD_LOGIC_VECTOR (4 downto 0);
            vga_b : out STD_LOGIC_VECTOR (4 downto 0);
            vga_g : out STD_LOGIC_VECTOR (5 downto 0);
            
            vga_hs : out STD_LOGIC;
            vga_vs : out STD_LOGIC
    );
    end component;

    signal tb_clk, tb_btn : std_logic := '0';
    
    signal tb_CTS, tb_RTS, tb_RXD, tb_TXD : std_logic := '0';
    
    signal tb_vga_r, tb_vga_b : std_logic_vector(4 downto 0) := (others => '0');
    signal tb_vga_g : std_logic_vector(5 downto 0) := (others => '0'); 
    signal tb_vga_hs, tb_vga_vs : std_logic := '0';

begin
    top_level : uproc_top_level_wrapper
        port map (
            CTS => tb_CTS,
            RTS => tb_RTS,
            RXD => tb_RXD,
            TXD => tb_TXD,
            btn_0 => tb_btn,
            clk => tb_clk,
            vga_b => tb_vga_b,
            vga_g => tb_vga_g,
            vga_hs => tb_vga_hs,
            vga_r => tb_vga_r,
            vga_vs => tb_vga_vs
        );

    clk_gen_proc : process 
    
    begin
        tb_clk <= '0';
        wait for 4 ns;
        
        tb_clk <= '1';
        wait for 4 ns;
    
    end process clk_gen_proc;

end Behavioral;
