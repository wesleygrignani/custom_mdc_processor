-- Design : multiplexador 2x1
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is 
port ( i_0   : in  std_logic_vector(7 downto 0);
       i_1   : in  std_logic_vector(7 downto 0);
       i_SEL : in  std_logic;
		 o_D   : out std_logic_vector(7 downto 0));
end mux2_1;

architecture arch_1 of mux2_1 is 
begin
  process(i_SEL, i_0, i_1) 
  begin
    if(i_SEL = '0') then
	   o_D <= i_0;
	 else
	   o_D <= i_1;
	 end if;
  end process;
end arch_1;