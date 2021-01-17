----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2018 14:56:09
-- Design Name: 
-- Module Name: TestBench - Behavioral
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

entity TestBench is
--  Port ( );
end TestBench;

architecture Structural of TestBench is
    component blink is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           left  : in  STD_LOGIC;
           haz  : in  STD_LOGIC;
           right  : in  STD_LOGIC;
           l : out std_logic_vector(3 DOWNTO 1);
           r : out std_logic_vector(3 DOWNTO 1));
   end component;
   
   -- signaux locaux
   signal clk : STD_LOGIC;
   signal reset_n : STD_LOGIC;
   signal left  : STD_LOGIC;
   signal haz  : STD_LOGIC;
   signal right  : STD_LOGIC;
   signal l : std_logic_vector(3 DOWNTO 1);
   signal r : std_logic_vector(3 DOWNTO 1);
   
   --Signaux locaux propres au banc de test
   SIGNAL sim_end : BOOLEAN := FALSE;
   SIGNAL mark_error : std_logic := '0';
   SIGNAL error_number : integer := 0;
   SIGNAL clk_gen : std_logic := '0';
   
begin
--Instanciation du composant UUT
    uut: Blink Port Map (
    clk => clk,
    reset_n => reset_n,
    left => left,
    haz  => haz,
    right=> right,
    l => l,
    r => r 
   );
   
   --PROCESS "clk_gengen" **********
   clk_gengen: PROCESS
   BEGIN
   IF sim_end = FALSE THEN
   clk_gen <= '1', '0' AFTER 1 ns;
   clk <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns;
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
   --fixer toutes les entrees du module à tester (UUT)
   PROCEDURE init IS
   BEGIN --completer ici
   reset_n <= '0';
   left <= '0';
   haz  <= '0';
   right <= '0';
   END init;
   
   --********** PROCEDURE "test_signal" **********
   PROCEDURE test_signal(signal_test,value: IN std_logic; erreur : IN integer) IS
   BEGIN
   IF signal_test/= value THEN
   mark_error <= '1', '0' AFTER 1 ns;
   error_number <= erreur;
   ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
   END IF;
   END test_signal;
   
   --********** PROCEDURE "test_vecteur" **********
   PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector (3 DOWNTO 1); erreur : IN integer) IS
   BEGIN
      IF signal_test/= value THEN
            mark_error <= '1', '0' AFTER 1 ns;
            error_number <= erreur;
            ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
      END IF;
   END test_vecteur;
  
   BEGIN --debut de la simulation temps t=0ns
   init; --appel procdure init
   ASSERT FALSE REPORT "Debut de la simulation" SEVERITY NOTE; --debut des tests
   sim_cycle(3);
   reset_n <= '1';
   sim_cycle(1);
   test_vecteur(l, "000", 1);
   test_vecteur(r, "000", 2);
   left  <= '1';
   sim_cycle(1);
   test_vecteur(l, "001", 3);
   sim_cycle(1);
   test_vecteur(l, "011", 4);
   sim_cycle(1);
   test_vecteur(l, "111", 5);
   sim_cycle(1);
   test_vecteur(l, "000", 6);
   left <=  '0';
   right <= '1';
   sim_cycle(1);
   test_vecteur(r, "100", 7);
   sim_cycle(1);
   test_vecteur(r, "110", 8);
   sim_cycle(1);
   test_vecteur(r, "111", 9);
   sim_cycle(1);
   test_vecteur(r, "000", 10);
   left <= '0';
   right <= '0';
   haz <= '1';
   sim_cycle(1);
   test_vecteur(l, "111", 11);
   test_vecteur(r, "111", 12);
   sim_cycle(1);
   test_vecteur(l, "000", 13);
   test_vecteur(r, "000", 14);
   sim_end <= TRUE;
   wait;

END PROCESS;

end;
