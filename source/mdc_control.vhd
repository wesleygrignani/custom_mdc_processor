-- Design : Bloco de controle
-- Autor  : Wesley Grignani
-- Data   : 28/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity mdc_control is 
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
end mdc_control;

architecture arch_1 of mdc_control is

type   t_STATE is (s_0, s_1, s_2, s_3, s_4, s_5, s_6);   -- new FSM type
signal r_STATE : t_STATE;       -- state register
signal w_NEXT  : t_STATE;       -- next state

begin

  -- Registrador de estados
  p_STATE: process(i_CLR,i_CLK)
  begin
    if (i_CLR ='1') then
      r_STATE <= s_0;           -- estado inicial
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;        -- proximo estado
    end if;
  end process;
 
  -- Função de proximo estado
  p_NEXT: process(r_STATE, i_GO, i_EQUAL, i_LESS)
  begin
    case (r_STATE) is          
      when s_0 => if (i_GO = '1') then
                    w_NEXT <= s_1;
                  else
                    w_NEXT <= s_0;
                  end if;
						
      when s_1 => w_NEXT <= s_2;
		
      when s_2 => if (i_EQUAL = '1') then
                    w_NEXT <= s_6;
                  else
                    w_NEXT <= s_3;
                  end if;
						
      when s_3 => if (i_LESS = '1') then
                    w_NEXT <= s_4;
                  else
                    w_NEXT <= s_5;
                  end if;
						
	   when s_4 => w_NEXT <= s_2;
      
		when s_5 => w_NEXT <= s_2;

      when s_6 => w_NEXT <= s_0;		
                  
      when others => w_NEXT <= s_0;
    end case;
  end process; 
  
  o_SEL_MUX_X  <= '1' when r_STATE = s_5 else '0';
  o_SEL_MUX_Y  <= '1' when r_STATE = s_4 else '0';
  o_RDY        <= '1' when r_STATE = s_6 else '0';
  o_LD_INPUT_X <= '1' when r_STATE = s_5 OR r_STATE = s_1 else '0';
  o_LD_INPUT_Y <= '1' when r_STATE = s_4 OR r_STATE = s_1 else '0';
  o_CLR_INPUT  <= '1' when r_STATE = s_0 else '0';
  o_CLR_OUT    <= '1' when r_STATE = s_1 else '0';
  o_LD_OUT     <= '1' when r_STATE = s_6 else '0';
  
end arch_1; 