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

-- un registre a decalage de 16bits, reset synchrone actif haut 
-- enable synchrone actif haut
entity regdec is 
    Port ( clk     : in STD_LOGIC;
           reset_n : in STD_LOGIC; -- synchrone actif haut
           serin  : in std_logic; -- registre d'entree
           dout  : out std_logic_vector (3 downto 0)); -- registre de sortie 4 bits 
end regdec;

architecture Behavioral of regdec is
    signal reg : std_logic_vector (3 downto 0); -- registre de 4 bits
begin

p1: process(clk, reset_n) begin
if reset_n = '0' then
    reg <= (OTHERS => '0');
elsif (clk'EVENT AND clk = '1') then
    --IF enable = '1' THEN
        reg <= serin & reg(3 downto 1);
    --END IF;
end if;
end process;

dout <= reg;

end Behavioral;
