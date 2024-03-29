----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2024 07:29:03 PM
-- Design Name: 
-- Module Name: echo_top - Behavioral
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

entity echo_top is
  Port ( 
    TXD, clk : in std_logic; 
    btn : in std_logic; 
    CTS, RTS, RXD : out std_logic
  
  );
end echo_top;

architecture Behavioral of echo_top is

component clock_div is
    port(
        clk : in std_logic;
        clk_enable : out std_logic
    );
end component;


component debounce is 
port (
    clk : in std_logic; 
    btn : in std_logic; 
    dbnc : out std_logic
); 
end component; 

component uart is 
    port (
        clk, en, send, rx, rst      : in std_logic;
        charSend                    : in std_logic_vector (7 downto 0);
        ready, tx, newChar          : out std_logic;
        charRec                     : out std_logic_vector (7 downto 0)
    
    ); 
end component; 

component echo is
  Port ( 
    clk, en, ready, newChar : in std_logic;
    charIn : in std_logic_vector(7 downto 0);
    send : out std_logic;
    charOut : out std_logic_vector(7 downto 0)
  
  );

end component; 

signal u1_dbnc_rst, u2_dbnc_btn, u3_div_en : std_logic;
signal u4_send : std_logic; 
signal u4_char : std_logic_vector(7 downto 0); 
signal u5_ready_rdy : std_logic; 


begin



    u2 : debounce
    port map (
        clk => clk,
        btn => btn,
        dbnc => u2_dbnc_btn
    );

    u3 : clock_div
    port map (
        clk  => clk,
        clk_enable => u3_div_en
    );
    
    u4 : echo 
    port map (
        clk => clk,                  
        newChar => u2_dbnc_btn,           
        charIn => u4_char,              
        en => u3_div_en,                 
        ready => u5_ready_rdy,
        charOut => u4_char,
        send => u4_send
    ); 
    
    u5 : uart
    port map (
        clk => clk, 
        en => u3_div_en, 
        send => u4_send, 
        rx => TXD, 
        rst => u1_dbnc_rst,
        charSend => u4_char,
        ready => u5_ready_rdy,
        tx => RXD
  ); 
    
    -- need to ground rts and cts
    RTS <= '0';
    CTS <= '0'; 


end Behavioral;
