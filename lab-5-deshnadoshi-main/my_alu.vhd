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
    clk, en : in std_logic; 
    opcode : in std_logic_vector(3 downto 0); 
    A : in std_logic_vector(15 downto 0);
    B : in std_logic_vector(15 downto 0);
    
    output : out std_logic_vector(15 downto 0)
      
  );
end my_alu;

architecture Behavioral of my_alu is

begin
process(clk)
begin

-- need to adjust this to have 16 bit output ??? 
-- adjust the lengths of A and B also 

if (rising_edge(clk) and en = '1') then

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
            output <= std_logic_vector(0 - unsigned (A)); -- same upto here, change after this
        when "0101" => 
            output <= std_logic_vector(shift_left(unsigned(A), 1));  
        when "0110" =>  --6
            output <= std_logic_vector(shift_right(unsigned(A), 1));     
        when "0111" => --7
            output <= std_logic_vector(shift_right(signed(A), 1));  
        
        when "1000" => --8 
             output <= A and B; 
             
        when "1001" => -- 9
            output <= A or B; 
        
        when "1010" => -- 10
            output <= A xor B; 
        
        when "1011" => -- 11
           if (signed(A) < signed(B)) then 
                output <= "0000000000000001";
           else 
                output <= "0000000000000000";
           end if; 
        
        when "1100" => -- 12, c
           if (signed(A) > signed(B)) then 
                output <= "0000000000000001";
           else 
                output <= "0000000000000000";
           end if;  
        
        when "1101" => -- 13, d -- need to ask if this onwards is unsigned
           if (unsigned(A) = unsigned(B)) then 
                output <= "0000000000000001";
           else 
                output <= "0000000000000000";
           end if;  
        
        
        when "1110" =>
            if (unsigned(A) < unsigned(B)) then 
                output <= "0000000000000001";
           else 
                output <= "0000000000000000";
           end if; 
     
        
        when "1111" =>
            if (unsigned(A) > unsigned(B)) then 
                output <= "0000000000000001";
           else 
                output <= "0000000000000000";
           end if;   
        
        when others =>
            output <= "0000"; 
             
        
    end case; 
    
end if; 


end process; 

end Behavioral;
