----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 15:24:29
-- Design Name: 
-- Module Name: Testbench - Behavioral
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

entity Testbench is
--  Port ( );
end Testbench;

architecture Structural of Testbench is
component cmp 
Port ( in1 : in STD_LOGIC_VECTOR (7 downto 0);
       in2 : in STD_LOGIC_VECTOR (7 downto 0);
       cmp : out std_logic_vector (2 downto 0));
end component;

--Signaux locaux pour instanciation composant UUT
--Inputs
signal in1 : std_logic_vector (7 downto 0);
signal in2 : std_logic_vector (7 downto 0);
--Outputs
signal loc_cmp : std_logic_vector (2 downto 0); -- signal ne peut pas avoir le meme nom que le component

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

begin

uut : cmp
Port Map (
    in1 => in1, 
    in2 => in2,
    cmp => loc_cmp
);

--********** PROCESS "clk_gengen" **********
clk_gengen: PROCESS
  BEGIN
  IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    --clk     <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns; --commenter si  on teste une fonction combinatoire (pas de clock)
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
  	in1 <= "00000000";
  	in2 <= "00000000";			
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(2 DOWNTO 0); erreur : IN integer) IS 
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
    test_vecteur(loc_cmp, "001", 1);
    
    in1 <= "00000001";
    sim_cycle(1);
    test_vecteur(loc_cmp, "010", 2);
    
    in2 <= "10000000";
    sim_cycle(1);
    test_vecteur(loc_cmp, "100", 3);
        		
	sim_end <= TRUE;
	wait;

END PROCESS;

end;
