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
    Port ( ebl : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end bascule;

architecture Behavioral of bascule is
begin

    p1:PROCESS (clk, rst)
    BEGIN
    IF rst = '0' THEN --reset asynchrone actif bas
        q <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN --flanc montant du signal clk
        IF ebl = '1' then
        q <= d;
        END IF;
    END IF;
    END process;

end Behavioral;
