-- Design : testbench
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity testbench is 
end testbench;

architecture arch_1 of testbench is 
component mdc_top is 
port( i_GO  : in  std_logic;
      i_CLR : in  std_logic;
	  i_CLK : in  std_logic;
	  i_X   : in  std_logic_vector(7 downto 0);
	  i_Y   : in  std_logic_vector(7 downto 0);
	  o_RDY : out std_logic;
	  o_D   : out std_logic_vector(7 downto 0));
end component;

signal w_i_GO, w_i_CLR, w_i_CLK, w_o_RDY : std_logic;
signal w_i_X, w_i_Y, w_o_D : std_logic_vector(7 downto 0);
constant c_CLK_PERIOD : time := 0.5 ns;


begin 
  u_DUV : mdc_top 
    port map(i_GO  => w_i_GO,
	         i_CLR => w_i_CLR,
			 i_CLK => w_i_CLK,
			 i_X   => w_i_X,
			 i_Y   => w_i_Y,
			 o_RDY => w_o_RDY,
			 o_D   => w_o_D);
				 
  p_CLK: process
  begin
    w_i_CLK <= '0';
    wait for c_CLK_PERIOD/2;  
    w_i_CLK <= '1';
    wait for c_CLK_PERIOD/2;  
  end process p_CLK;

  p_INPUTS: process
  begin 
    w_i_GO  <= '0';
    w_i_X   <= "00011011";
	w_i_Y   <= "00001001";
	w_i_CLR <= '1';
	wait for c_CLK_PERIOD;
	 
	w_i_GO  <= '1';
    w_i_X   <= "00011011";
	w_i_Y   <= "00001001";
	w_i_CLR <= '0';
	 
	wait for c_CLK_PERIOD;
	wait for c_CLK_PERIOD;
	wait for c_CLK_PERIOD;
	wait for c_CLK_PERIOD;
	 
	 
	assert false report "Test done." severity note;
	wait;
  end process;
end arch_1;