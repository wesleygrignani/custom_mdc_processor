-- Design : Entidade topo
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity mdc_top is 
port( i_GO  : in  std_logic;
      i_CLR : in  std_logic;
	  i_CLK : in  std_logic;
	  i_X   : in  std_logic_vector(7 downto 0);
	  i_Y   : in  std_logic_vector(7 downto 0);
	  o_RDY : out std_logic;
	  o_D   : out std_logic_vector(7 downto 0));
end mdc_top;

architecture arch_1 of mdc_top is

component mdc_datapath is 
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
end component;

component mdc_control is 
port( i_GO         : in  std_logic;  -- sinal de inicio do circuito
      i_EQUAL      : in  std_logic;  -- sinal (x = y)
      i_LESS       : in  std_logic;  -- sinal (x < y)
	  i_CLK        : in  std_logic;  -- sinal de clock do circuito
	  i_CLR        : in  std_logic;  -- sinal de clear do registrador de estados
	  o_SEL_MUX_X  : out std_logic;  -- seletor do multiplexador x do datapath
	  o_SEL_MUX_Y  : out std_logic;  -- seletor do multiplexador y do datapath
	  o_LD_INPUT_X : out std_logic;  -- sinal de load do registrador de entrada x do datapath
	  o_LD_INPUT_Y : out std_logic;  -- sinal de load do registrador de entrada y do datapath
	  o_CLR_INPUT  : out std_logic;  -- sinal de clear dos registradores de entrada
	  o_LD_OUT     : out std_logic;  -- load do registrador de saida
	  o_CLR_OUT    : out std_logic;  -- clear do registrador de saida 
      o_RDY        : out std_logic);  
end component;

signal w_SEL_MUX_X, w_SEL_MUX_Y, w_LD_INPUT_X, w_LD_INPUT_Y, w_CLR_INPUT, w_LD_OUT, w_CLR_OUT, w_LESS, w_EQUAL : std_logic;

begin
  u_DATAPATH : mdc_datapath 
    port map (i_SEL_MUX_X   => w_SEL_MUX_X,
              i_SEL_MUX_Y   => w_SEL_MUX_Y,
		      i_LD_INPUT_X  => w_LD_INPUT_X,
		      i_LD_INPUT_Y  => w_LD_INPUT_Y,
		      i_CLR_INPUT   => w_CLR_INPUT,
		      i_LD_OUT      => w_LD_OUT,
		      i_CLR_OUT     => w_CLR_OUT,
		      i_CLK         => i_CLK,
		      i_X           => i_X,
		      i_Y           => i_Y,
		      o_D           => o_D,
              o_LESS        => w_LESS,
		      o_EQUAL       => w_EQUAL);
	
  u_CONTROL : mdc_control
    port map (i_GO          => i_GO, 
              i_EQUAL       => w_EQUAL,
              i_LESS        => w_LESS,
		      i_CLK         => i_CLK,
		      i_CLR         => i_CLR,
		      o_SEL_MUX_X   => w_SEL_MUX_X,
		      o_SEL_MUX_Y   => w_SEL_MUX_Y,
		      o_LD_INPUT_X  => w_LD_INPUT_X,
		      o_LD_INPUT_Y  => w_LD_INPUT_Y,
		      o_CLR_INPUT   => w_CLR_INPUT,
		      o_LD_OUT      => w_LD_OUT,
		      o_CLR_OUT     => w_CLR_OUT,
		      o_RDY         => o_RDY); 


end arch_1;