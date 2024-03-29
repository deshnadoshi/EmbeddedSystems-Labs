library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_top is
  port ( 
    btn : in std_logic_vector(3 downto 0);  
    clk : in std_logic; 
    
    sw : in std_logic_vector(3 downto 0); 
    led : out std_logic_vector(3 downto 0)
  
  );
end counter_top;

architecture Behavioral of counter_top is

component clock_div is
    port(
        clk : in std_logic;
        clk_enable : out std_logic
    );
end component;


component debounce is 
port (
    clk : in std_logic; 
    btn : in std_logic; --single bit input
    dbnc : out std_logic
); 
end component; 


component fancy_counter is 
port (
    
    clk : in std_logic;
    en : in std_logic;
    clk_en : in std_logic;
    rst : in std_logic; 
    ld : in std_logic;
    dir : in std_logic; 
    updn : in std_logic; 
    val : in std_logic_vector(3 downto 0); 
    
    cnt : out std_logic_vector(3 downto 0)

); 
end component; 

signal u1_dbnc_rst : std_logic; 
signal u2_dbnc_en : std_logic; 
signal u3_dbnc_updn : std_logic; 
signal u4_dbnc_ld : std_logic; 

signal counter : std_logic_vector(3 downto 0) := (others => '0');
signal value_register : std_logic_vector(3 downto 0) := (others => '0');
signal u6_clkdiv_en : std_logic; 

begin


    u1 : debounce
    port map (
        clk => clk,
        btn => btn(0),
        dbnc => u1_dbnc_rst
    );

    u2 : debounce
    port map (
        clk => clk,
        btn => btn(1),
        dbnc => u2_dbnc_en
    );

    u3 : debounce
    port map (
       clk => clk,
        btn => btn(2),
        dbnc => u3_dbnc_updn
    );

    u4 : debounce
    port map (
        clk => clk,
        btn => btn(3),
        dbnc => u4_dbnc_ld
    );
    
    u5 : clock_div
    port map (
        clk  => clk,
        clk_enable => u6_clkdiv_en
    );
    
    u6 : fancy_counter
    port map (
        clk  => clk,
        clk_en => u6_clkdiv_en,
        dir => sw(0),
        en => u2_dbnc_en,
        ld => u4_dbnc_ld,
        rst => u1_dbnc_rst,
        updn => u3_dbnc_updn,
        val => sw,
        cnt => counter
    );
    
    led <= counter; 
    value_register <= sw; 


end Behavioral;