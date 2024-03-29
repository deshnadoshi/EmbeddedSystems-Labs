
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder is
  port (
    C0 : in std_logic;
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0); 
    
    C4 : out std_logic; 
    S : out std_logic_vector(3 downto 0) 
    
  );
end ripple_adder;


architecture Behavioral of ripple_adder is

component adder is 
port (
    A : in std_logic; 
    B : in std_logic; 
    Cin : in std_logic; 
    
    S : out std_logic; 
    Cout : out std_logic

); 
end component; 

signal C1, C2, C3 : std_logic; 

begin

u1 : adder
port map(

    A => A(0),
    B => B(0),
    Cin => C0,
    S => S(0),
    Cout => C1

);

u2 : adder
port map(

    A => A(1),
    B => B(1),
    Cin => C1,
    S => S(1),
    Cout => C2

);  

u3 : adder
port map(

    A => A(2),
    B => B(2),
    Cin => C2,
    S => S(2),
    Cout => C3

); 

u4 : adder
port map(

    A => A(3),
    B => B(3),
    Cin => C3,
    S => S(3),
    Cout => C4

);   



end Behavioral;