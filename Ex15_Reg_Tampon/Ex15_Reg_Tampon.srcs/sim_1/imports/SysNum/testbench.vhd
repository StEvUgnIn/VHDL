LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT regtampon 
		Port ( enable  : in STD_LOGIC; -- synchrone actif haut
           reset_s : in STD_LOGIC; -- asynchrone actif bas
           reset_n : in STD_LOGIC; -- synchrone actif haut
           clk     : in STD_LOGIC;
           d       : in std_logic_vector  (7 downto 0);
           q       : out std_logic_vector (7 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
signal enable  : STD_LOGIC; -- synchrone actif haut
signal reset_s : STD_LOGIC; -- asynchrone actif bas
signal reset_n : STD_LOGIC; -- synchrone actif haut
signal clk     : STD_LOGIC;
signal d       : std_logic_vector  (7 downto 0);
--Outputs
signal q       : std_logic_vector (7 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: regtampon
    Port Map ( 
        enable  => enable,
        reset_s => reset_s, 
        reset_n => reset_n, 
        clk     => clk,
        d       => d,
        q       => q);

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
        reset_n <= '0';
        reset_s <= '0';
        d <= "10000000";
        enable <= '1';
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(7 DOWNTO 0); erreur : IN integer) IS 
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
    sim_cycle(2);
    test_vecteur(q, (OTHERS => '0'), 1);
    
    reset_n <= '1';
    sim_cycle(1);
    test_vecteur(q, "10000000", 2);
    
    enable <= '0';
    d <= "00000001";
    sim_cycle(1);
    test_vecteur(q, "10000000", 3);
    
    enable <= '1';
    sim_cycle(1);
    test_vecteur(q, "00000001", 4);

    reset_s <= '1';
    sim_cycle(1);
    test_vecteur(q, (OTHERS => '0'), 5);
    
    reset_s <= '0';
    sim_cycle(1);
    test_vecteur(q, "00000001", 6);
    
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

