-- Design : comparador igual
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comp_equal is 
port (i_A     : in  std_logic_vector(7 downto 0);
      i_B     : in  std_logic_vector(7 downto 0);
		o_EQUAL : out std_logic);
end comp_equal;

architecture arch_1 of comp_equal is 
begin
  process(i_A, i_B) -- verificação (x = y)
  begin
    if(i_A = i_B) then
	   o_EQUAL <= '1';
	 else
	   o_EQUAL <= '0';
	 end if;
  end process;
end arch_1;