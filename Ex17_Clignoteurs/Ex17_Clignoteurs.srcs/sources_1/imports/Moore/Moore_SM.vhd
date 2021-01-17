library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Blink is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           left : in  STD_LOGIC;
           haz : in  STD_LOGIC;
           right : in  STD_LOGIC;
           l : out std_logic_vector(3 DOWNTO 1);
           r : out std_logic_vector(3 DOWNTO 1));
end Blink;

architecture Behavioral of Blink is

--Declare type, subtype
  subtype t_state is	std_logic_vector(5 DOWNTO 0);

--Declare constantes
  constant c_IDLE	: t_state	:= "000000";
  constant c_L1		: t_state	:= "001000";
  constant c_L2		: t_state	:= "011000";
  constant c_L3	    : t_state	:= "111000";
  constant c_R1		: t_state	:= "000100";
  constant c_R2     : t_state   := "000110";
  constant c_R3     : t_state   := "000111";
  constant c_LR3    : t_state   := "111111";

--Declare signaux
SIGNAL state :	t_state;

begin

P1:PROCESS(clk, reset_n) BEGIN
	IF haz = '0' and left = '0' and right = '0' THEN
		state <= c_IDLE;
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE state IS
			WHEN c_IDLE =>
			        IF left = '1' THEN
			            state <= c_L1;
					ELSIF haz = '1' THEN 
						state <= c_LR3;
					ELSIF right = '1' THEN
					   state <= c_R1;
					ELSE
						state <= c_IDLE;
					END IF;
			WHEN c_L1 =>
						state <= c_L2;
			WHEN c_L2 =>
						state <= c_L3;
			WHEN c_L3 =>
						state <= c_IDLE;
			WHEN c_R1 => 
						state <= c_R2;
			WHEN c_R2 =>
			            state <= c_R3;
            WHEN c_R3 =>
                        state <= c_IDLE;
			WHEN OTHERS =>
				state <= c_IDLE;
		END CASE;
	END IF;
END PROCESS;
	   	
--Assignation combinatoire des sorties en fonction des états de la machine
l  <= 	"111" WHEN state = c_lr3 OR state = c_l3 ELSE
		"011" WHEN state = c_l2 ELSE
		"001" WHEN state = c_l1 ELSE
		"000";

r  <= 	"111" WHEN state = c_lr3 OR state = c_r3 ELSE
		"110" WHEN state = c_r2 ELSE
		"100" WHEN state = c_r1 ELSE
		"000";
				
end Behavioral;

