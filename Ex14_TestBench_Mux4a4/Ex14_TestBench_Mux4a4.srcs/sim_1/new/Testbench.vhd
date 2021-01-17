----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 14:28:22
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

architecture Behavioral of Testbench is

component mux4a4
Port ( ina : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
       inb : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
       inc : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
       ind : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
       sel : in STD_LOGIC_VECTOR (1 downto 0);  -- selecteur de canal
       mux : out STD_LOGIC_VECTOR (3 downto 0));
end component;
    
    signal ina : STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
    signal inb : STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
    signal inc : STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
    signal ind : STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
    signal sel : STD_LOGIC_VECTOR (1 downto 0);  -- selecteur de canal
    signal mux : STD_LOGIC_VECTOR (3 downto 0);  -- sortie multiplexée de 4 bit
    
--Signaux locaux propres au banc de test
    SIGNAL sim_end : BOOLEAN := FALSE;
    SIGNAL mark_error : std_logic := '0';
    SIGNAL error_number : integer := 0;
    SIGNAL clk_gen : std_logic := '0';
begin

    uut: mux4a4
    Port map (
        ina => ina,
        inb => inb,
        inc => inc, 
        ind => ind,
        sel => sel,
        mux => mux
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
        ina <= "1010";
        inb <= "0101";
        inc <= "1111";
        ind <= "0000";
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
        PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector (3 DOWNTO 0); erreur : IN integer) IS
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

        sel <= "00";
        sim_cycle(1);
        test_vecteur(mux, ina, 1);
        
        sel <= "01";
        sim_cycle(1);
        test_vecteur(mux, inb, 2);
        
        sel <= "10";
        sim_cycle(1);
        test_vecteur(mux, inc, 3);
        
        sel <= "11";
        sim_cycle(1);
        test_vecteur(mux, ind, 4);
        
        sim_end <= TRUE;
        wait;
    end process;
end Behavioral;
