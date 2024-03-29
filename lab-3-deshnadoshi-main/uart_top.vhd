----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 01:26:27 PM
-- Design Name: 
-- Module Name: uart_top - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_top is
  Port ( 
    TXD, clk : in std_logic; 
    btn : in std_logic_vector(1 downto 0); 
    CTS, RTS, RXD : out std_logic
  
  );
end uart_top;

architecture Behavioral of uart_top is

-- need components for sender, clock div, debouncer, uart (given file)

component sender is 
    port(
        rst, clk, en, btn, ready : in std_logic;
        send : out std_logic;
        char : out std_logic_vector(7 downto 0) 

    ); 
end component; 

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

signal u1_dbnc_rst, u2_dbnc_btn, u3_div_en : std_logic;
signal u4_send : std_logic; 
signal u4_char : std_logic_vector(7 downto 0); 
signal u5_ready_rdy : std_logic; 

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
        dbnc => u2_dbnc_btn
    );

    u3 : clock_div
    port map (
        clk  => clk,
        clk_enable => u3_div_en
    );
    
    u4 : sender 
    port map (
        rst => u1_dbnc_rst,
        clk => clk,
        en => u3_div_en,
        btn => u2_dbnc_btn,
        ready => u5_ready_rdy,
        send => u4_send,
        char => u4_char
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
