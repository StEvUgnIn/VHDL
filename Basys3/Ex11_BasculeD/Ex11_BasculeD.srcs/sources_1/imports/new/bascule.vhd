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

entity bascule is
    Port ( enable  : in STD_LOGIC; -- enable
           reset_n : in STD_LOGIC; -- reset synchrone
           clk : in STD_LOGIC;     -- clock
           d : in STD_LOGIC;       -- d
           q : out std_logic_vector (2 downto 0));     -- q
end bascule;

architecture Behavioral of bascule is
    shared variable i : integer := 0;
begin

    p1:PROCESS (clk, reset_n)
    BEGIN
    IF reset_n = '0' THEN --reset asynchrone actif bas
        q(i) <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN --flanc montant du signal clk
        IF enable = '1' then
        q(i) <= d;
        i := (i+1) mod 3;
        END IF;
    END IF;
    
    END process;

end Behavioral;
