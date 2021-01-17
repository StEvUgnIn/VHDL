----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 13:14:28
-- Design Name: 
-- Module Name: testbench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
end testbench;

architecture structure of testbench is

--Declaration du composant UUT (Unit Under Test)
component divfreq
    Port ( clk      : in STD_LOGIC; -- a mapper a clk_gen
           reset_n  : in STD_LOGIC;
           sw       : in std_logic_vector (7 downto 0); -- va de 255 a 0
           div      : out STD_LOGIC);  -- largeur de periode clk
end component;

--Signaux locaux pour instanciation composant UUT
--input
signal reset_n  : STD_LOGIC;
signal clk      : STD_LOGIC;
signal sw       : std_logic_vector (7 downto 0); -- va de 255 a 0
--output
signal div      : STD_LOGIC;

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

begin

--Intanciation du composant UUT
uut: divfreq 
PORT MAP(
    clk     => clk, 
    reset_n => reset_n,
    sw      => sw,
    div     => div
    );

--********** PROCESS "clk_gengen" **********
clk_gengen: PROCESS
  BEGIN
  IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    clk     <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns; --commenter si  on teste une fonction combinatoire (pas de clock)
    wait for 25 ns;
  ELSE
    wait;
  END IF;
END PROCESS;

--********** PROCESS "run" **********
run: PROCESS

  PROCEDURE sim_cycle(num : IN integer) IS
  BEGIN
    FOR index IN 1 TO num LOOP
      wait until clk_gen'EVENT AND clk_gen = '1';
    END LOOP;
  END sim_cycle;

  --********** PROCEDURE "init" **********
  --fixer toutes les entrees du module à tester (DUT) sauf clk
  PROCEDURE init IS
  BEGIN
    reset_n <= '0'; -- mettre le signal a un etat connu
    sw      <= "00000100";				
  END init;

  --********** PROCEDURE "test_signal" **********
  PROCEDURE test_signal(signal_test, value: IN std_logic; erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_signal;

 --********** PROCEDURE "test_vecteur" **********
  PROCEDURE test_vecteur(signal_test, value: IN std_logic; erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_vecteur;


BEGIN --debut de la simulation temps t=0ns

	init;  --appel procdure init
	ASSERT FALSE REPORT "la simulation est en cours" SEVERITY NOTE;
	--debut des tests
    sim_cycle(3);
    test_vecteur(div, '0',1); --counter = 4
    reset_n <= '1'; -- on fait les tests maintenant avec le reset async a 1
    sim_cycle(1);
    test_vecteur(div, '0',2); --counter = 3
    sim_cycle(1);
    test_vecteur(div, '0',3);    --counter = 2
    sim_cycle(1);
    test_vecteur(div, '0',4);    --counter = 1
    sim_cycle(1);
    test_vecteur(div, '0',5);    --counter = 0
    sim_cycle(1);
    test_vecteur(div, '1',6);    --counter = 4
    sim_cycle(1);
    test_vecteur(div, '0',7);    --counter = 3
    sim_cycle(1);
    test_vecteur(div, '0',8);    --counter = 2
    sim_cycle(1);
    test_vecteur(div, '0',9);    --counter = 1
    sim_cycle(1);
    test_vecteur(div, '0',10);--counter = 0
    sw    <= "00010011";  --19 -> divise par 20
    sim_cycle(1);
    test_vecteur(div, '1',11);--counter = 19
    --sim_cycle(1);
    --test_vecteur(div, '1',12);--counter = 19
    for n in 1 to 19 loop
        sim_cycle(1);    
        test_vecteur(div, '0',13);
    end loop;            --counter = 0
    sim_cycle(1);
    test_vecteur(div, '1',14);--counter = 19
    for n in 1 to 19 loop
        sim_cycle(1);    
        test_vecteur(div, '0',15);
    end loop;            --counter = 0
    sim_cycle(1);
    test_vecteur(div, '1',16);--counter = 19
    
	sim_end <= TRUE;
	wait;

END PROCESS;
-- afficher signal local dans la simulation : scope : "add to Wave windows" > objects > clic-droit > "changer le format d'affichage (ex. unsigned)"
end;
