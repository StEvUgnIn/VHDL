library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Moore_SM is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           entree : in  STD_LOGIC;
           restart : in  STD_LOGIC;
			  aff_ebl : out  STD_LOGIC;
           sortie : out  STD_LOGIC_VECTOR (6 downto 0));
end Moore_SM;

architecture Behavioral of Moore_SM is

--Declare type, subtype
  subtype t_state is	std_logic_vector(2 DOWNTO 0);

--Declare constantes
  constant c_ZERO			: t_state	:= "000";
  constant c_UN_UN		: t_state	:= "001";
  constant c_DEUX_UN		: t_state	:= "010";
  constant c_TROIS_UN	: t_state	:= "011";
  constant c_MAX_UN		: t_state	:= "100";

--Declare signaux
SIGNAL state :	t_state;

begin

aff_ebl <= '1';

P1:PROCESS(clk, reset_n) BEGIN
	IF reset_n = '0' THEN
		state <= c_ZERO;
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE state IS
			WHEN c_ZERO =>
					IF entree = '1' THEN 
						state <= c_UN_UN;
					ELSE
						state <= c_ZERO;
					END IF;
			WHEN c_UN_UN =>
					IF entree = '1' THEN 
						state <= c_DEUX_UN;
					ELSE
						state <= c_ZERO;
					END IF;
			WHEN c_DEUX_UN =>
					IF entree = '1' THEN 
						state <= c_TROIS_UN;
					ELSE
						state <= c_ZERO;
					END IF;
			WHEN c_TROIS_UN =>
					IF entree = '1' THEN 
						state <= c_MAX_UN;
					ELSE
						state <= c_ZERO;
					END IF;
			WHEN c_MAX_UN => 
					IF restart = '1' THEN 
						state <= c_ZERO;
					ELSE
						state <= c_MAX_UN;
					END IF;
			WHEN OTHERS =>
				state <= c_ZERO;
		END CASE;
	END IF;
END PROCESS;


--Assignation des sorties combinatoire fonction des etats uniquement (Machine de Moore)
	   	
sortie <= 	"0111111" WHEN state = c_ZERO		 ELSE
				"0000110" WHEN state = c_UN_UN	 ELSE
				"1011011" WHEN state = c_DEUX_UN	 ELSE
				"1001111" WHEN state = c_TROIS_UN ELSE
				"1010100" WHEN state = c_MAX_UN	 ELSE
				"-------";
				
end Behavioral;

