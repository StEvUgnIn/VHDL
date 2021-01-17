----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2018 13:00:45
-- Design Name: 
-- Module Name: bascule - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Ecrire la description VHDL comportementale synthétisable d'un diviseur de fréquence programmable de 2 à 256, 
-- avec reset asynchrone. Le signal de sortie doit avoir une impulsion d'une largeur d'une période de clk.
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
use IEEE.NUMERIC_STD.ALL;

entity divfreq is
    Port ( clk      : in STD_LOGIC;
           reset_n  : in STD_LOGIC;
           reset_s  : in STD_LOGIC;
           sw       : in std_logic_vector (11 downto 0); -- va de 4096 a 0
           load     : in std_logic;
           enable   : in std_logic;
           sens     : in std_logic;
           div      : out STD_LOGIC);  -- largeur de periode clk
end divfreq;

architecture Behavioral of divfreq is

signal counter : std_logic_vector (11 downto 0); -- diviseur de fréquence de 2 a 256 bits

begin

    p1:PROCESS (clk, reset_n) BEGIN
    IF reset_n = '0' THEN --reset asynchrone actif bas
        counter <= sw;
        div     <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN --flanc montant du signal clk
        IF reset_s = '1' THEN
            counter <= sw;
            div <= '0';
        ELSIF load = '1' THEN
            
        ELSIF enable = '1' THEN       
            IF  sens = '1' THEN
                IF UNSIGNED(counter) = 96 THEN -- divise par counter + 1 => donc represente par 2 a 256
                    counter <= sw;
                    div     <= '1';
                ELSE
                    counter <= std_logic_vector (unsigned(counter) + 1);
                    div     <= '0';
                END IF;
            ELSE
                IF UNSIGNED(counter) = 4000 THEN -- divise par counter + 1 => donc represente par 2 a 256
                    counter <= sw;
                    div     <= '1';
                ELSE
                    counter <= std_logic_vector (unsigned(counter) - 1);
                    div     <= '0';
                END IF;
            END IF;
        END IF;
    END IF;
    END process;

end Behavioral;
