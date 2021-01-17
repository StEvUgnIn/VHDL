----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2018 14:27:00
-- Design Name: 
-- Module Name: bcd7seg - Behavioral
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

entity testbench is
end testbench;

architecture Behavioral of testbench is

    component bcd7seg
    Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);  -- entrees   4 bits
           aff : out STD_LOGIC_VECTOR (6 downto 0); -- affichage 7 segments (bits)
           aff_enable : out STD_LOGIC);             -- activation affichage seg_7
    end component;
    
    signal BCD : STD_LOGIC_VECTOR (3 downto 0);  -- entrees   4 bits
    signal aff : STD_LOGIC_VECTOR (6 downto 0); -- affichage 7 segments (bits)
    signal aff_enable : STD_LOGIC;

    --Signaux locaux propres au banc de test
    SIGNAL sim_end : BOOLEAN := FALSE;
    SIGNAL mark_error : std_logic := '0';
    SIGNAL error_number : integer := 0;
    SIGNAL clk_gen : std_logic := '0';

begin

    uut: bcd7seg
    PORT MAP (
        BCD => BCD,
        aff => aff,
        aff_enable => aff_enable
    );
    
    --********** PROCESS "clk_gengen" **********
    clk_gengen: PROCESS
    BEGIN
    IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    --clk <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns;
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
    PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector (6 DOWNTO 0); erreur : IN integer) IS
    BEGIN
    IF signal_test/= value THEN
    mark_error <= '1', '0' AFTER 1 ns;
    error_number <= erreur;
    ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
    END IF;
    END test_vecteur;
    BEGIN --debut de la simulation temps t=0ns
    init; --appel procdure init
    ASSERT FALSE REPORT "Debut de la simulation" SEVERITY NOTE;
    --debut des tests
    sim_cycle(2);
    BCD <= "0000";
    sim_cycle(1);
    test_vecteur(aff, "0111111", 1);
    BCD <= "0010";
    sim_cycle(1);
    test_vecteur(aff, "1011011", 2);
    BCD <= "0011";
    sim_cycle(1);    
    test_vecteur(aff, "1001111", 3);
    BCD <= "0100";
    sim_cycle(1);
    test_vecteur(aff, "1100110", 4);    
    BCD <= "0101";    
    sim_cycle(1);
    test_vecteur(aff, "1101101", 5);    
    BCD <= "0110";    
    sim_cycle(1);
    test_vecteur(aff, "1111100", 6);
    BCD <= "0111";
    sim_cycle(1);
    test_vecteur(aff, "0000111", 7);
    BCD <= "1000";
    sim_cycle(1);
    test_vecteur(aff, "1111111", 8);
    BCD <= "1001";
    sim_cycle(1);
    test_vecteur(aff, "1101111", 9);
    BCD <= "1111";
    sim_cycle(1);
    test_vecteur(aff, "-------", 10);
    sim_end <= TRUE;
    wait;
    END PROCESS;
END Behavioral;