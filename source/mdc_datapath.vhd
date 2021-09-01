-- Design : Bloco operacional
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity mdc_datapath is 
port ( i_SEL_MUX_X  : in  std_logic;  -- seletor do mux da entrada X
       i_SEL_MUX_Y  : in  std_logic;  -- seletor do mux da entrada y
		   i_LD_INPUT_X : in  std_logic;  -- sinal de load do registrador da entrada x
		   i_LD_INPUT_Y : in  std_logic;  -- sinal de load do registrador da entrada y
		   i_CLR_INPUT  : in  std_logic;  -- sinal de clear dos registradores de entrada x e y
		   i_LD_OUT     : in  std_logic;  -- sinal de load do registrador de saida 
		   i_CLR_OUT    : in  std_logic;  -- sinal de clear do registrador de saida 
		   i_CLK        : in  std_logic;  -- sinal de clock
		   i_X          : in  std_logic_vector(7 downto 0);  -- entrada X
		   i_Y          : in  std_logic_vector(7 downto 0);  -- entrada Y
		   o_D          : out std_logic_vector(7 downto 0);  -- saida D
       o_LESS       : out std_logic;  -- sinal de (x < y) 
		   o_EQUAL      : out std_logic);  -- sinal de (x = y)
end mdc_datapath;


architecture arch_1 of mdc_datapath is
component mux2_1 is  -- multiplexador 
port ( i_0   : in  std_logic_vector(7 downto 0);
       i_1   : in  std_logic_vector(7 downto 0);
       i_SEL : in  std_logic;
		   o_D   : out std_logic_vector(7 downto 0));
end component;

component register_8bit is  -- registrador 
port (i_CLK : in  std_logic;
      i_A   : in  std_logic_vector(7 downto 0);
		  i_LD  : in  std_logic;
		  i_CLR : in  std_logic;
	    o_D   : out std_logic_vector(7 downto 0));
end component;

component comp_less is -- comparador <
port (i_A    : in std_logic_vector(7 downto 0);
      i_B    : in std_logic_vector(7 downto 0);
		  o_LESS : out std_logic);
end component;

component comp_equal is -- comparador =
port (i_A     : in  std_logic_vector(7 downto 0);
      i_B     : in  std_logic_vector(7 downto 0);
		  o_EQUAL : out std_logic);
end component;

component comp_sub is  -- bloco de subtração
port( i_A    : in  std_logic_vector(7 downto 0);
      i_B    : in  std_logic_vector(7 downto 0);
		  o_D    : out std_logic_vector(7 downto 0));
end component;

signal w_MUX_X, w_MUX_Y, w_MUX_OUT_X, w_MUX_OUT_Y : std_logic_vector(7 downto 0); -- sinais multiplexador 
signal w_REG_OUT_X, w_REG_OUT_Y : std_logic_vector(7 downto 0);  -- sinais registradores
signal w_OUT : std_logic_vector(7 downto 0);  -- sinal de saida do registrador final 

begin

  u_MUX_X : mux2_1 -- mux x
    port map (i_0   => i_X,
              i_1   => w_MUX_X,
              i_SEL => i_SEL_MUX_X,
		          o_D   => w_MUX_OUT_X);
				
  u_MUX_Y : mux2_1  -- mux y
    port map (i_0   => i_Y,
              i_1   => w_MUX_Y,
              i_SEL => i_SEL_MUX_Y,
		          o_D   => w_MUX_OUT_Y);
  
  u_REG_X : register_8bit  -- registrador x
    port map (i_CLK => i_CLK,
              i_A   => w_MUX_OUT_X,
		          i_LD  => i_LD_INPUT_X,
		          i_CLR => i_CLR_INPUT,
		          o_D   => w_REG_OUT_X);
				  
  u_REG_Y : register_8bit  -- registrador y
    port map (i_CLK => i_CLK,
              i_A   => w_MUX_OUT_Y,
		          i_LD  => i_LD_INPUT_Y,
		          i_CLR => i_CLR_INPUT,
		          o_D   => w_REG_OUT_Y);
				  
  u_REG_OUT : register_8bit  -- registrador de saida x
    port map (i_CLK => i_CLK,
              i_A   => w_REG_OUT_X,
		          i_LD  => i_LD_OUT,
		          i_CLR => i_CLR_OUT,
		          o_D   => w_OUT);
				  
  u_LESS : comp_less  -- bloco comparador <
    port map (i_A    => w_REG_OUT_X,
              i_B    => w_REG_OUT_Y,
	            o_LESS => o_LESS);
				  
  u_EQUAL : comp_equal  -- bloco comparador =
    port map (i_A     => w_REG_OUT_X,
              i_B     => w_REG_OUT_Y,
		          o_EQUAL => o_EQUAL);
				  
  u_SUBX_Y : comp_sub
    port map (i_A   => w_REG_OUT_X,
              i_B   => w_REG_OUT_Y,
		          o_D   => w_MUX_X);
				  
  u_SUBY_X : comp_sub
    port map (i_A   => w_REG_OUT_Y,
              i_B   => w_REG_OUT_X,
		          o_D   => w_MUX_Y);
				  
  o_D <= w_OUT;
				  
end arch_1;