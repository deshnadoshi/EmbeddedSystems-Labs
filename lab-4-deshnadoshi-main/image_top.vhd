----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Deshna Doshi
-- 
-- Create Date: 03/30/2024 09:45:36 AM
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

entity image_top is
  Port ( 
    clk : in std_logic; 
    vga_hs, vga_vs : out std_logic;
    vga_r, vga_b : out std_logic_vector(4 downto 0);
    vga_g : out std_logic_vector(5 downto 0)
    
  );
end image_top;

architecture Behavioral of image_top is

-- need components for clk div, ip block aka picture, pixels, vga ctrl

component clock_div is 
    port (
        clk : in std_logic; 
        clk_enable : out std_logic
    ); 
end component; 

component picture is 
    port ( 
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    
    );
end component; 

component pixel_pusher is 
    port ( 
        clk, en : in std_logic;
        vs, vid : in std_logic;
        pixel : in std_logic_vector(7 downto 0);
        hcount : in std_logic_vector(9 downto 0);
        R, B : out std_logic_vector(4 downto 0);
        G : out std_logic_vector(5 downto 0); 
        addr : out std_logic_vector(17 downto 0)

    
    ); 
end component; 

component vga_ctrl is 
    port ( 
        clk, en : in std_logic;
        hcount, vcount : out std_logic_vector(9 downto 0); 
        vid, hs, vs : out std_logic
    ); 
end component; 

signal signal_clk_en : std_logic;  
signal signal_hcount, signal_vcount : std_logic_vector(9 downto 0);
signal signal_vid, signal_vs, signal_hs : std_logic;
signal signal_pixel : std_logic_vector(7 downto 0);
signal signal_addr : std_logic_vector(17 downto 0);


begin


    u1 : clock_div 
    port map (
        clk => clk, 
        clk_enable => signal_clk_en
    ); 
    
    u2 : picture 
    port map (
        clka => signal_clk_en,
        addra => signal_addr,
        douta => signal_pixel
    
    ); 
    
    u3 : pixel_pusher
    port map (
        clk => clk, 
        en => signal_clk_en, 
        vs => signal_vs, 
        vid => signal_vid,
        pixel => signal_pixel,
        hcount => signal_hcount,
        R => vga_r,
        G => vga_g,
        B => vga_b,
        addr => signal_addr
    
    ); 
    
    u4 : vga_ctrl
    port map (
        clk => clk, 
        en => signal_clk_en,
        hcount => signal_hcount,
        vcount => signal_vcount,
        vid => signal_vid,
        hs => signal_hs,
        vs => signal_vs
    
    ); 
    
    vga_hs <= signal_hs;
    vga_vs <= signal_vs;




end Behavioral;
