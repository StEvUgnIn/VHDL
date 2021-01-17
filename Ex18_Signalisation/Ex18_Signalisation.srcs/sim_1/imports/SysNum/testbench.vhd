LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT signalisation 
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           capteur : in  STD_LOGIC;
           timer   : in  STD_LOGIC;
           feuxP1 : out std_logic_vector (1 downto 0);
           feuxP2 : out std_logic_vector (1 downto 0);
           feuxS  : out std_logic_vector (1 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
signal clk      :   STD_LOGIC;
signal reset_n  :   STD_LOGIC;
signal capteur  :   STD_LOGIC;
signal timer    :   STD_LOGIC;
--Outputs
signal feuxP1   :   std_logic_vector (1 downto 0);
signal feuxP2   :   std_logic_vector (1 downto 0);
signal feuxS    :   std_logic_vector (1 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: signalisation
    PORT MAP(
        clk => clk, 
        reset_n => reset_n, 
        capteur => capteur, 
        timer   => timer, 
        feuxP1  => feuxP1, 
        feuxP2  => feuxP2, 
        feuxS   => feuxS
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
    reset_n <= '0';
    capteur <= '0';			
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(1 DOWNTO 0); erreur : IN integer) IS 
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
    
    -- Etat connu / PRVSECR
    test_vecteur(feuxP1, "01", 1);
    test_vecteur(feuxP2, "01", 1);
    test_vecteur(feuxS,  "10", 1);
    
    -- PRVSECR
    reset_n <= '1';
    sim_cycle(1);
    test_vecteur(feuxP1, "01", 2);
    test_vecteur(feuxP2, "01", 2);
    test_vecteur(feuxS,  "10", 2);
    
    -- PROSECR
    capteur <= '1';
    sim_cycle(1);
    test_vecteur(feuxP1, "11", 3);
    test_vecteur(feuxP2, "11", 3);
    test_vecteur(feuxS,  "10", 3);
    
    -- PRRSECR
    sim_cycle(1);
    test_vecteur(feuxP1, "10", 4);
    test_vecteur(feuxP2, "10", 4);
    test_vecteur(feuxS,  "10", 4);
    
    -- PRRSECV
    sim_cycle(1);
    test_vecteur(feuxP1, "10", 5);
    test_vecteur(feuxP2, "10", 5);
    test_vecteur(feuxS,  "01", 5);
    
    -- PRRSECV - ELSE
    sim_cycle(1);
    test_vecteur(feuxP1, "10", 6);
    test_vecteur(feuxP2, "10", 6);
    test_vecteur(feuxS,  "01", 6);

    -- PRRSECO
    capteur <= '0';
    timer   <= '1';
    sim_cycle(1);
    test_vecteur(feuxP1, "10", 7);
    test_vecteur(feuxP2, "10", 7);
    test_vecteur(feuxS,  "11", 7);
        
    -- PRRSECR2
    sim_cycle(1);
    test_vecteur(feuxP1, "10", 8);
    test_vecteur(feuxP2, "10", 8);
    test_vecteur(feuxS,  "10", 8);

    -- retour à PRVSECR
    sim_cycle(1);
    test_vecteur(feuxP1, "01", 9);
    test_vecteur(feuxP2, "01", 9);
    test_vecteur(feuxS,  "10", 9);
    
    -- contrôle de ELSE
    sim_cycle(1);
    test_vecteur(feuxP1, "01", 10);
    test_vecteur(feuxP2, "01", 10);
    test_vecteur(feuxS,  "10", 10);
    
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

