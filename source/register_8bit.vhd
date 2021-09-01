-- Design : registrador 8 bits
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity register_8bit is 
port (i_CLK : in  std_logic;
      i_A   : in  std_logic_vector(7 downto 0);
		i_LD  : in  std_logic;
		i_CLR : in  std_logic;
		o_D   : out std_logic_vector(7 downto 0));
end register_8bit;


architecture arch_1 of register_8bit is
begin
  process(i_CLR, i_CLK)  -- registrador de entrada do sinal x
  begin
    if(i_CLR = '1') then  
      o_D <= (others => '0');
    elsif (rising_edge(i_CLK)) then  
      if(i_LD = '1') then  
        o_D <= i_A;  
      end if;
    end if;
  end process;
end arch_1;