-- Design : bloco subtração
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comp_sub is 
port( i_A    : in  std_logic_vector(7 downto 0);
      i_B    : in  std_logic_vector(7 downto 0);
		o_D    : out std_logic_vector(7 downto 0));
end comp_sub;

architecture arch_1 of comp_sub is
begin
  o_D <= i_A - i_B;
end arch_1;