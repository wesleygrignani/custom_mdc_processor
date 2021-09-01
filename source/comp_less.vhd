-- Design : Comparador menor 
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comp_less is 
port (i_A    : in std_logic_vector(7 downto 0);
      i_B    : in std_logic_vector(7 downto 0);
		o_LESS : out std_logic);
end comp_less;

architecture arch_1 of comp_less is
begin
  process(i_A, i_B) -- verificação (x < y),
  begin
    if(i_A < i_B) then
	   o_LESS <= '1';
	 else
	   o_LESS <= '0';
	 end if;
  end process;
end arch_1;