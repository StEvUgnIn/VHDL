library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
  subtype t_state is	std_logic_vector(2 DOWNTO 0);

--Declare constantes
constant c_idle : t_state	:= "000";
constant c_l1	: t_state	:= "001";
constant c_l2	: t_state	:= "010";
constant c_l3	: t_state	:= "011";
constant c_lr3	: t_state	:= "100";
constant c_r1	: t_state	:= "101";
constant c_r2	: t_state	:= "110";
constant c_r3	: t_state	:= "111";

--Declare signaux
signal state : t_state; -- Signal interne pour state

begin

P1:PROCESS(clk, reset_n) BEGIN
	IF reset_n = '0' THEN
		state <= (OTHERS => '0');
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE state IS
			WHEN c_IDLE =>
			        IF haz = '1' THEN 
                        state <= c_LR3;
                    ELSIF left = '1' THEN
                        state <= c_L1;
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

