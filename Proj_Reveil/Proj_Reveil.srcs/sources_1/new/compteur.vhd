----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 11:30:07
-- Design Name: 
-- Module Name: compteur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_BCD is -- @TODO ecrire une fonction pour hd, hu, md, mu
    Port ( clk 		: in  STD_LOGIC;
           reset_n 	: in  STD_LOGIC;
           enable 	: in  STD_LOGIC;
           -- sel : in std_logic_vector (3 downto 0);
           carry_in : in STD_LOGIC;
           carry_out : out  STD_LOGIC;
           count 	: out  STD_LOGIC_VECTOR (3 downto 0));
end counter_BCD;

architecture Behavioral of counter_BCD is

subtype t_sel is std_logic_vector (3 downto 0);

-- declaration des constantes
constant c_hd : t_sel := "1000";
constant c_hu : t_sel := "0100";
constant c_md : t_sel := "0010";
constant c_mu : t_sel := "0001";

-- declaration des signaux locaux
-- entree
SIGNAL carry : std_logic := carry_in;
-- sortie
SIGNAL counter : std_logic_vector(3 downto 0);

BEGIN

--Compteur BCD
P1:PROCESS (clk, reset_n)
BEGIN
	IF reset_n = '0' THEN
		counter <= (OTHERS => '0');
	ELSIF carry = '1' THEN
        IF counter = "1001" THEN
            counter <= "0000";
        ELSE
            counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) + 1);
        END IF;
        carry <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
	   IF enable = '1' THEN
            IF counter = "1001" THEN
                counter <= "0000";
            ELSE                                
                counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) + 1);
            END IF;
        END IF;
	END IF;
END PROCESS;

--generation signal de sortie carry_out combinatoire
carry_out <= '1' WHEN counter = "1001" ELSE '0';

--Assignation inconditionelle du compteur sur sortie
count <= counter;

end Behavioral;


