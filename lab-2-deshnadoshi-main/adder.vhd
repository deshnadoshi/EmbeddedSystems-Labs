
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
  port ( 
    A : in std_logic; 
    B : in std_logic; 
    Cin : in std_logic; 
    
    S : out std_logic; 
    Cout : out std_logic
    
  
  );
end adder;

architecture Behavioral of adder is

signal xor1 : std_logic;
signal xor2 : std_logic; 
signal and1 : std_logic;
signal and2 : std_logic; 

begin


    xor1 <= A XOR B; 
    xor2 <= xor1 XOR Cin; 
    
    and1 <= xor1 AND Cin; 
    and2 <= B AND A; 
    
    Cout <= and1 OR and2; 
    S <= xor2; 

end Behavioral;
