----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 10:20:21 AM
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

entity controls is
  Port ( 
    clk, en, rst : in std_logic; 
    
    rID1, rID2 : out std_logic_vector(4 downto 0);
    wr_enR1, wr_enR2 : out std_logic;
    regrD1, regrD2 : in std_logic_vector(15 downto 0);
    regwD1, regwD2 : out std_logic_vector(15 downto 0);
    
    fbRST : out std_logic; 
    fbAddr1 : out std_logic_vector(11 downto 0); 
    fbDin1 : in std_logic_vector(15 downto 0); 
    fbDout1 : out std_logic_vector(15 downto 0); 
    fbWr_en : out std_logic; 
    
    irAddr : out std_logic_vector(13 downto 0); 
    irWord : in std_logic_vector(31 downto 0); 
    
    dAddr : out std_logic_vector(14 downto 0); 
    d_wr_en : out std_logic; 
    dOut : out std_logic_vector(15 downto 0);
    dIn : in std_logic_vector(15 downto 0); 
    
    aluA, aluB : out std_logic_vector(15 downto 0);
    aluOp : out std_logic_vector(3 downto 0); 
    aluResult : in std_logic_vector(15 downto 0); 
    
    ready, newChar : in std_logic; 
    send_UART : out std_logic; -- needed to change the name of the signal, because it wouldn't let me assign send to 0 in the reset portion
    charRec : in std_logic_vector(7 downto 0); 
    charSend : out std_logic_vector(7 downto 0)
  
  );
  
  
end controls;

architecture Behavioral of controls is

type state_type is (fetch, decode, rops, iops, jops, calc, store, jr, recv, rpix, wpix, send, equals, nequal, ori, lw, sw, jmp, jal, clrscr, finish, decode_clksync, rops_clksync, iops_clksync, calc_clksync, store_clksync, rpix_clksync, wpix_clksync, lw_clksync, sw_clksync);
signal state: state_type := fetch; 

signal opcode : std_logic_vector(4 downto 0) := (others => '0'); 
signal immediate : std_logic_vector(15 downto 0) := (others => '0'); 
signal PC : std_logic_vector(15 downto 0) := (others => '0'); 

signal assembly_instruction : std_logic_vector(31 downto 0) := (others => '0'); 
signal alu_res : std_logic_vector(15 downto 0) := (others => '0'); 

signal reg1_memaddr, reg2_memaddr, reg3_memaddr : std_logic_vector(4 downto 0) := (others => '0');  
signal reg1_val, reg2_val, reg3_val : std_logic_vector(15 downto 0) := (others => '0'); 


begin

process(clk)
begin

    if (rising_edge(clk)) then 
    
        if (rst = '1') then 
            state <= fetch; 
    
            opcode <= (others => '0'); 
            immediate <= (others => '0'); 
            PC <= (others => '0'); 
    
            assembly_instruction <= (others => '0'); 
            alu_res <= (others => '0'); 
            
            rID1 <= (others => '0');
            rID2 <= (others => '0');
            wr_enR1 <= '0';
            wr_enR2 <= '0';
            regwD1 <= (others => '0');
            regwD2 <= (others => '0');
            
            fbRST <= '1';
            fbAddr1 <= (others => '0');
            fbDout1 <= (others => '0');
            irAddr <= (others => '0'); 

            dAddr <= (others => '0');
            d_wr_en <= '0';  
            dOut <= (others => '0');

            aluA <= (others => '0');
            aluB <= (others => '0');
            aluOp <= (others => '0');

            charSend <= (others => '0'); 
            send_UART <= '0'; 

               
        elsif (en = '1') then 
            case state is 
                when fetch =>
		    rID1 <= "00001";
                    PC <= regrD1; 
                    state <= decode; 
                
                when decode =>
                    irAddr <= PC(13 downto 0);
                    wr_enR1 <= '1'; --enable the writing to register 1

		    rID1 <= "00001"; 
                    state <= decode_clksync; --need to account for the clock cycle 
                
                when decode_clksync =>
                    if (irWord(31 downto 30) = "00") or ((irWord(31 downto 30) = "01")) then 
                        state <= rops; 
                    elsif (irWord(31 downto 30) = "10") then 
                        state <= iops; 
                    else
                        state <= jops; 
                    end if; 
                    
                    assembly_instruction <= irWord; 
                    regwD1 <= std_logic_vector(unsigned(PC) + 1);
                    wr_enR1 <= '0'; --deassert control signal here
                    
                
                when rops =>
                    -- break up instruction into dif arguments, opcode and three registers 
                    opcode <= assembly_instruction(31 downto 27); 
                    
                    reg1_memaddr <= assembly_instruction(26 downto 22); 
                    reg2_memaddr <= assembly_instruction(21 downto 17); 
                    reg3_memaddr <= assembly_instruction(16 downto 12); 
                    
                    -- rID1 <= reg2_memaddr; 
                    -- rID2 <= reg3_memaddr; 
                    rID1 <= assembly_instruction(21 downto 17);
                    rID2 <= assembly_instruction(16 downto 12); 
                    
                    state <= rops_clksync; 
                    
                when rops_clksync =>
                    reg2_val <= regrD1;
                    reg3_val <= regrD2; 
                    
                    -- deassert the control sginals again
                    rID1 <= (others => '0'); 
                    rID2 <= (others => '0'); 
                    
                    if (opcode = "01101") then 
                        state <= jr;
                    elsif (opcode = "01100") then 
                        state <= recv; 
                    elsif (opcode = "01111") then 
                        state <= rpix; 
                    elsif (opcode = "01110") then 
                        state <= wpix; 
                    elsif (opcode = "01011") then 
                        state <= send;
                    else 
                        state <= calc; 
                    end if; 
                                                    
                when iops =>
                    opcode <= assembly_instruction(31 downto 27);
                    
                    reg1_memaddr <= assembly_instruction(26 downto 22);  
                    reg2_memaddr <= assembly_instruction(21 downto 17);
                    immediate <= assembly_instruction(16 downto 1);   
                    
                    rID1 <= assembly_instruction(26 downto 22); 
                    rID2 <= assembly_instruction(21 downto 17); 
                    
                    state <= iops_clksync; 
                    
                when iops_clksync => 
                    reg1_val <= regrD1; 
                    reg2_val <= regrD2;
                    
                    if (opcode(2 downto 0) = "000") then 
                        state <= equals; 
                    elsif (opcode(2 downto 0) = "001") then 
                        state <= nequal; 
                    elsif (opcode(2 downto 0) = "010") then 
                        state <= ori; 
                    elsif (opcode(2 downto 0) = "011") then
                        state <= lw;
                    else
                        state <= sw;  
                    end if; 
                        
                when jops =>
                    opcode <= assembly_instruction(31 downto 27);
                    immediate <= assembly_instruction(26 downto 11); 

                    if (opcode = "11000") then 
                        state <= jmp;
                    elsif (opcode = "11001") then 
                        state <= jal; 
                    else
                        state <= clrscr; 
                    end if; 
                when calc =>
                      aluOp <= opcode(3 downto 0);
                      
                      aluA <= reg2_val; 
                      aluB <= reg3_val; 
                      state <= calc_clksync; 
                
                when calc_clksync =>
                    alu_res <= aluResult;
                    state <= store; 
                when store =>
                    wr_enR1 <= '1';   
                    rID1 <= reg1_memaddr; 

                    state <= store_clksync; 
                when store_clksync =>
                    regwD1 <= alu_res;
                    state <= finish;
                when jr =>
                    alu_res <= regrD1; 
                    state <= store; 
                when recv => 
                    alu_res <= "00000000" & charRec;
                    if newChar = '0' then
                        state <= recv;
                    else
                        state <= store;
                    end if;

                when rpix =>
                    fbAddr1 <= reg2_val(11 downto 0);
                    state <= rpix_clksync; 
                when rpix_clksync =>
                    alu_res <= fbDin1;
                    state <= store; 
                when wpix =>
                    fbAddr1 <= regrD1(11 downto 0);
          	        
                    fbWr_en <= '1';
          	        state <= wpix_clksync;

                when wpix_clksync =>
                    fbDout1 <= reg2_val;
                    state <= finish;
                when send =>
                    send_UART <= '1';
        	          charSend <= regrD1(7 downto 0);
        	       
        	          if ready = '1' then
        	              state <= finish;
        	          else
        	              state <= send;
        	           end if;
                when equals =>
                    if (reg1_val = reg2_val) then 
                        alu_res <= immediate;
                        reg1_memaddr <= "00001";
                    end if; 
                    state <= store; 
                when nequal =>
                    if (reg1_val /= reg2_val) then 
                        alu_res <= immediate;
                        reg1_memaddr <= "00001";
                    end if; 
                    state <= store; 
                when ori =>
                    alu_res <= immediate OR reg2_val;
                    state <= store;
                when lw =>
                    dAddr <= std_logic_vector(unsigned(immediate(14 downto 0)) + unsigned(reg2_val(14 downto 0)));
                    state <= lw_clksync;

                when lw_clksync => 
                    alu_res <= dIn;
                    state <= store; 
                when sw =>
                    d_wr_en <= '1'; 
                    dAddr <= std_logic_vector(unsigned(immediate(14 downto 0)) + unsigned(reg2_val(14 downto 0)));
                    state <= sw_clksync;
                when sw_clksync =>
                    dOut <= reg1_val; 
                    state <= finish; 
                when jmp =>
                    rID1 <= "00001";  
	                wr_enR1 <= '1';
	                regwD1 <= immediate; 
                    state <= finish;

                when jal =>
                    regwD1 <= immediate; 
                    regwD2 <= PC; 
                    wr_enR1 <= '0'; 
                    wr_enR2 <= '0'; 
                    state <= finish; 
                    
                when clrscr =>
                    fbRST <= '1'; 
                    state <= finish; 
                when finish =>
                    assembly_instruction <= (others => '0'); 
                    alu_res <= (others => '0'); 
                    
                    rID1 <= (others => '0');
                    rID2 <= (others => '0');
                    wr_enR1 <= '0';
                    wr_enR2 <= '0';
                    regwD1 <= (others => '0');
                    regwD2 <= (others => '0');
                    
                    fbRST <= '0';
                    fbAddr1 <= (others => '0');
                    fbDout1 <= (others => '0');
                    irAddr <= (others => '0'); 
        
                    dAddr <= (others => '0');
                    d_wr_en <= '0';  
                    dOut <= (others => '0');
        
                    aluA <= (others => '0');
                    aluB <= (others => '0');
                    aluOp <= (others => '0');
        
                    charSend <= (others => '0'); 
                    send_UART <= '0';
                    reg1_memaddr <= (others => '0'); 
                    reg2_memaddr <= (others => '0'); 
                    reg3_memaddr <= (others => '0'); 

                    reg1_val <= (others => '0'); 
                    reg2_val <= (others => '0'); 
                    reg3_val <= (others => '0'); 

                    state <= fetch; 
        
            end case; 
        
        
        end if; -- end rst = 1 and en = 1
    
    
    end if; 

end process; 


end Behavioral;