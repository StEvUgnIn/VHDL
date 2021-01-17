----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2018 13:00:45
-- Design Name: 
-- Module Name: regtampon - Behavioral
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

-- un registre tampon de 8bits, reset asynchrone actif bas, reset synchrone actif haut 
-- et signal enable synchrone actif haut.
entity regtampon is 
    Port ( enable  : in STD_LOGIC; -- synchrone actif haut
           reset_s : in STD_LOGIC; -- asynchrone actif bas
           reset_n : in STD_LOGIC; -- synchrone actif haut
           clk     : in STD_LOGIC;
           d       : in std_logic_vector  (7 downto 0);
           q       : out std_logic_vector (7 downto 0));
end regtampon;

architecture Behavioral of regtampon is
begin

p1: process(clk, reset_n) begin
    if reset_n = '0' then
        Q <= (OTHERS => '0');
    elsif (clk'EVENT AND clk = '1') then
        if reset_s = '1' then
            Q <= (OTHERS => '0');
        elsif enable = '1' then
            Q <= D;
        end if;
    end if;
end process;

end Behavioral;
