library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
  port ( 
  
    opcode : in std_logic_vector(3 downto 0); 
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    
    output : out std_logic_vector(3 downto 0)
      
  );
end my_alu;

architecture Behavioral of my_alu is

begin
process(opcode)
begin

case opcode is 
    when "0000" =>
        output <= std_logic_vector(unsigned(A) + unsigned(B)); 
        
    when "0001" =>
        output <= std_logic_vector(unsigned(A) - unsigned(B)); 
    when "0010" =>
        output <= std_logic_vector(unsigned(A) + 1);
    when "0011" =>
        output <= std_logic_vector(unsigned(A) - 1);
    when "0100" => 
        output <= std_logic_vector(0 - unsigned (A));
    when "0101" =>
        if (unsigned(A) > unsigned(B)) then
            output <= "0001"; 
        else 
            output <= "0000"; 
        end if; 
    when "0110" => 
        -- add the 0 to the end
        output(3) <= A(2); 
        output(2) <= A(1); 
        output(1) <= A(0); 
        output(0) <= '0'; 

    when "0111" =>
        -- add the 0 to the beginning
        output(3) <= '0'; 
        output(2) <= A(3); 
        output(1) <= A(2); 
        output(0) <= A(1); 
    
    when "1000" =>
        -- need signed for arithmetic shifting
         output <= std_logic_vector(shift_right(unsigned(A), 1)); 
         
    when "1001" =>
        output <= not A; 
    
    when "1010" => 
        output <= A and B; 
    
    when "1011" => 
        output <= A or B; 
    
    when "1100" =>
        output <= A xor B; 
    
    when "1101" =>
        output <= A xnor B; 
    
    when "1110" =>
        output <= A nand B; 
    
    when "1111" =>
        output <= A nor B; 
    
    when others =>
        output <= "0000"; 
         
    
end case; 
end process; 

end Behavioral;
