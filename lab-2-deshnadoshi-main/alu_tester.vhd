----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 08:34:17 AM
-- Design Name: 
-- Module Name: alu_tester - Behavioral
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

entity alu_tester is
  Port ( 
    btn : in std_logic_vector(3 downto 0); 
    sw : in std_logic_vector(3 downto 0);
    clk : in std_logic;  
    
    led : out std_logic_vector(3 downto 0)
  
  );
end alu_tester;

architecture Behavioral of alu_tester is

signal A_val : std_logic_vector(3 downto 0);
signal B_val : std_logic_vector(3 downto 0); 
signal opcode_val : std_logic_vector(3 downto 0); 

signal output_tester : std_logic_vector(3 downto 0); 

signal btn_dbnc : std_logic_vector(3 downto 0); 

component my_alu is 
port (
    opcode : in std_logic_vector(3 downto 0); 
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    
    output : out std_logic_vector(3 downto 0)
); 
end component; 

component debounce is 
port (
    clk   : in std_logic; 
    btn   : in std_logic; 
    dbnc  : out std_logic

); 
end component; 

begin
    process(clk)
    
    begin
    
    if (rising_edge(clk)) then 
        -- load values into opcode, A, B
        if (btn_dbnc(2) = '1') then 
            -- load opcode
            opcode_val <= sw; 
        elsif (btn_dbnc(1) = '1') then 
            -- load A
            A_val <= sw;
        elsif (btn_dbnc(0) = '1') then 
            -- load B
            B_val <= sw; 

        -- reset the signals when button 3 is pressed
        elsif (btn_dbnc(3) = '1') then 
            opcode_val <= "0000"; 
            A_val <= "0000"; 
            B_val <= "0000"; 
            
        end if; 
        
        -- need to assign output to the led's 
        led <= output_tester; 
        
    
    end if; 
    
    
    end process; 

    u1 : my_alu
    port map (
        A => A_val, 
        B => B_val, 
        output => output_tester,
        opcode => opcode_val
    ); 

    u2 : debounce
    port map (
        clk => clk,
        btn => btn(0),
        dbnc => btn_dbnc(0)
    );

    u3 : debounce
    port map (
        clk => clk,
        btn => btn(1),
        dbnc => btn_dbnc(1)
    );

    u4 : debounce
    port map (
       clk => clk,
        btn => btn(2),
        dbnc => btn_dbnc(2)
    );

    u5 : debounce
    port map (
        clk => clk,
        btn => btn(3),
        dbnc => btn_dbnc(3)
    );




end Behavioral;
