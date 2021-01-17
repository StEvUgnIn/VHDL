----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2018 12:55:56
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

component bascule
Port ( ebl : in STD_LOGIC;
       rst : in STD_LOGIC;
       clk : in STD_LOGIC;
       d : in STD_LOGIC;
       q : out STD_LOGIC);
end component;

signal ebl : std_logic;
signal rst : std_logic;
signal clk : std_logic;
signal d : std_logic;
signal q : std_logic;

--Signaux locaux propres au banc de test
SIGNAL sim_end : BOOLEAN := FALSE;
SIGNAL mark_error : std_logic := '0';
SIGNAL error_number : integer := 0;
SIGNAL clk_gen : std_logic := '0';

begin

uut: bascule
Port Map (
    ebl => ebl,
    rst => rst,
    d   => d,
    clk => clk,
    q   => q
);

--********** PROCESS "clk_gengen" **********
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
rst <= '0';
ebl <= '1';
d   <= '1';
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
PROCEDURE test_vecteur(signal_test, value: IN std_logic; erreur : IN integer) IS
BEGIN
IF signal_test/= value THEN
mark_error <= '1', '0' AFTER 1 ns;
error_number <= erreur;
ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
END IF;
END test_vecteur;

BEGIN --debut de la simulation temps t=0ns
init; --appel procedure init
ASSERT FALSE REPORT "Debut de la simulation" SEVERITY NOTE;

--debut des tests
sim_cycle(2);
-- verifier le reset synchrone et que le programme fonctionne dans un etat connu
-- pas d'assignation
test_vecteur(q, '0', 1);

rst <= '1';
sim_cycle(1);
test_vecteur(q, '1', 2);

ebl <= '0';
sim_cycle(1);
test_vecteur(q, '1', 3);

d   <= '0';
sim_cycle(1);
test_vecteur(q, '1', 4);

rst <= '0';
sim_cycle(1);
test_vecteur(q, '0', 5);

ebl <= '1';
sim_cycle(1);
test_vecteur(q, '0', 6);

d   <= '1';
sim_cycle(1);
test_vecteur(q, '0', 7);

d   <= '1';
ebl <= '0';
sim_cycle(1);
test_vecteur(q, '0', 8);

sim_end <= true;

wait;
END PROCESS;

end;
