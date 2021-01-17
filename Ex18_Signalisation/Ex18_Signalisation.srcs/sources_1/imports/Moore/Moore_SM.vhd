-- @TODO ouvrir OneNote
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Signalisation is
    Port ( clk      : in  STD_LOGIC;
           reset_n  : in  STD_LOGIC;
           capteur  : in  STD_LOGIC;
           timer    : in  STD_LOGIC;
           feuxP1   : out std_logic_vector (1 downto 0);
           feuxP2   : out std_logic_vector (1 downto 0);
           feuxS    : out std_logic_vector (1 downto 0));
end Signalisation;

architecture Behavioral of Signalisation is

--Declare type, subtype
  subtype t_state is	std_logic_vector(2 DOWNTO 0);

--Declare constantes
-- convention bit(1)=R, bit(0)=V
  constant c_vert   : std_logic_vector (1 downto 0) := "10";
  constant c_orange : std_logic_vector (1 downto 0) := "11";
  constant c_rouge  : std_logic_vector (1 downto 0) := "01";

  constant c_PRVSECR  :	t_state := "000";
  constant c_PROSECR  :	t_state := "001";
  constant c_PRRSECR  :	t_state := "010";
  constant c_PRRSECV  :	t_state := "011";
  constant c_PRRSECO  :	t_state := "100";
  constant c_PRRSECR2 :	t_state := "101";

--Declare signaux
  signal state : t_state;

begin

P1:PROCESS(clk, reset_n) BEGIN
	IF reset_n = '0' THEN
		state <= c_PRVSECR;
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE state IS
			WHEN c_PRVSECR =>
					IF capteur = '1' THEN 
						state <= c_PROSECR;
                    ELSE
                        state <= c_PRVSECR;
					END IF;
			WHEN c_PROSECR =>
					IF capteur = '1' THEN 
						state <= c_PRRSECR;
					END IF;
			WHEN c_PRRSECR =>
					IF capteur = '1' THEN 
						state <= c_PRRSECV;
					END IF;
			WHEN c_PRRSECV =>
					IF timer = '1' THEN 
						state <= c_PRRSECO;
					ELSE
                        state <= c_PRRSECV;
                    END IF;
			WHEN c_PRRSECO => 
					IF timer = '1' THEN 
						state <= c_PRRSECR2;
					END IF;
			WHEN c_PRRSECR2 =>
			         IF timer = '1' THEN
                        state <= c_PRVSECR;
                     END IF;
			WHEN OTHERS =>
				state <= c_PRVSECR;
		END CASE;
	END IF;
END PROCESS;


--Assignation des sorties combinatoire fonction des etats uniquement (Machine de Moore)
feuxP1 <= c_rouge  WHEN state = c_PRVSECR ELSE
          c_orange WHEN state = c_PROSECR ELSE
          c_vert;
feuxP2 <= c_rouge  WHEN state = c_PRVSECR ELSE
          c_orange WHEN state = c_PROSECR ELSE
          c_vert;
feuxS  <= c_orange WHEN state = c_PRRSECO ELSE
          c_rouge  WHEN state = c_PRRSECV ELSE
          c_vert;
				
end Behavioral;

