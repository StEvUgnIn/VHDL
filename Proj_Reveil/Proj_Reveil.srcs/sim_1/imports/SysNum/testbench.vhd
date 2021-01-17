LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT FSM 
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           hr  : in std_logic;
           dec : in std_logic;
           inc : in std_logic;
           ok  : in std_logic;
           sw  : in std_logic_vector (15 downto 0);
           buzzer : out std_logic;
           bcd : out std_logic_vector (6 downto 0);
           aff_enable : out std_logic_vector (3 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
signal clk : STD_LOGIC;
signal reset_n : STD_LOGIC;
signal hr  : std_logic;
signal dec : std_logic;
signal inc : std_logic;
signal ok  : std_logic;
signal sw  : std_logic_vector (15 downto 0);
--Outputs
signal buzzer : std_logic;
signal bcd : std_logic_vector (6 downto 0);
signal aff_enable : std_logic_vector (3 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: FSM
PORT MAP(
    clk => clk,
    reset_n => reset_n,
    hr  => hr,
    dec => dec,
    inc => inc,
    ok  => ok,
    sw  => sw,
    buzzer => buzzer,
    bcd => bcd,
    aff_enable => aff_enable	           			
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
    hr <= '0';
    inc <= '1';
    dec <= '0';
    ok <= '0';
    sw <= "0000100100100011";
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(6 DOWNTO 0); erreur : IN integer) IS 
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
	sim_cycle(20);
	test_signal(buzzer, '0', 1);
    aff_enable <= "1000";
	sim_cycle(2);
	test_vecteur(bcd, (OTHERS => '0'), 1);
	aff_enable <= "0100";
	sim_cycle(2);
	test_vecteur(bcd, (OTHERS => '0'), 1);
	aff_enable <= "0010";
	sim_cycle(2);
	test_vecteur(bcd, (OTHERS => '0'), 1);
	aff_enable <= "0001";
	sim_cycle(2);
	test_vecteur(bcd, (OTHERS => '0'), 1);
		
	reset_n <= '1';
	sim_cycle(20);
	
    -- chargement de l'heure 09:23 pui affichage
    sim_cycle(20); 
    aff_enable <= "1000";
    sim_cycle(2);
    test_vecteur(bcd, "0000000", 3);
    aff_enable <= "0100";
    sim_cycle(2);
    test_vecteur(bcd, "1001111", 3);
    aff_enable <= "0010";
    sim_cycle(2);
    test_vecteur(bcd, "1011011", 3);
    aff_enable <= "0001";
    sim_cycle(2);
    test_vecteur(bcd, "1111100", 3);
    
    inc <= '0'; -- le bouton inc est lâché
    hr <= '1';
    inc <= '1';
    sw <= "0001001000000000";
    -- chargement de l'heure de l'alarme
    sim_cycle(20);
    test_signal(buzzer, '0', 4);
    aff_enable <= "1000";
    sim_cycle(2);
    test_vecteur(bcd, "0000011", 4);
    aff_enable <= "0100";
    sim_cycle(2);
    test_vecteur(bcd, "1110110", 4);
    aff_enable <= "0010";
    sim_cycle(2);
    test_vecteur(bcd, "0000000", 4);
    aff_enable <= "0001";
    sim_cycle(2);
    test_vecteur(bcd, "0000000", 4);
    
    hr <= '0';
    inc <= '0';
    dec <= '1';
    sim_cycle(20); -- activation de l'alarme
    test_signal(buzzer, '0', 5);
    
    dec <= '0';
    sim_cycle(1000); -- lancement de l'alarme
    test_signal(buzzer, '1', 5);
    
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

