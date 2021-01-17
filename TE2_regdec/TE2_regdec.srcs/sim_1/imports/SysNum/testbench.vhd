LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT reg_dec 
    Port ( 
		clk 		: in std_logic;
		reset_n 	: in std_logic;
		reset_s 	: in std_logic;
		enable 		: in std_logic;
		load 		: in std_logic;
		dir 		: in std_logic;
		parin		: in std_logic_vector(15 downto 0);
		serin 		: in std_logic;
		dout 		: out std_logic_vector(15 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
signal clk      : STD_LOGIC;
signal reset_n  : STD_LOGIC; -- synchrone actif haut
signal reset_s  : STD_LOGIC; -- asynchrone actif bas
signal enable   : STD_LOGIC; -- synchrone actif haut
signal load     : std_logic;
signal dir 	    : std_logic;
signal parin	: std_logic_vector(15 downto 0);
signal serin    : std_logic;
--Outputs
signal dout     : std_logic_vector(15 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: reg_dec
    Port Map ( 
        clk     => clk,
        reset_n => reset_n, 
        reset_s => reset_s, 
        enable  => enable,
        load    => load, 
        dir     => dir,
        parin   => parin,
        serin   => serin,
        dout    => dout);

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
        load <= '1';
        serin <= '1';
        parin <= "1010101010101010"; -- valeur arbitraire
        enable <= '1';
        dir    <= '1';
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(15 DOWNTO 0); erreur : IN integer) IS 
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
    test_vecteur(dout, (OTHERS=>'0'), 1); -- etat connu
        
    reset_n <= '1';
    sim_cycle(1);
    test_vecteur(dout, "1010101010101010", 2);
    
    sim_end <= TRUE;
    
    load <= '0';
    sim_cycle(1);
    test_vecteur(dout, "1101010101010101", 3);
        
    reset_s <= '1';
    sim_cycle(1);
    test_vecteur(dout, (OTHERS=>'0'), 4);

    reset_s <= '0';
    dir <= '0';    
    sim_cycle(1);
    test_vecteur(dout, "0000000000000001", 5);
    
--    test_vecteur(dout, "1101010101010101", 6); -- decalage a gauche de serin
    
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

