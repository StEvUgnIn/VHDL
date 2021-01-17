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
--entity regdec is 
--    Port ( enable  : in STD_LOGIC; -- asynchrone actif haut
--           reset_n : in STD_LOGIC; -- synchrone actif haut
--           clk     : in STD_LOGIC;
--           serin   : in std_logic; -- registre serin de 16 bits
--           serout  : out std_logic -- registre de sortie
--           );
--end regdec;

entity reg_dec is
    Port ( 
		clk 		: in std_logic;
		reset_n 	: in std_logic;
		reset_s 	: in std_logic;
		enable 		: in std_logic;
		load 		: in std_logic;
		dir 		: in std_logic;
		parin		: in std_logic_vector(15 downto 0);
		serin 		: in std_logic;
		dout 		: out std_logic_vector(15 downto 0));
end reg_dec;


architecture Behavioral of reg_dec is
    signal reg : std_logic_vector (15 downto 0);
begin

p1: process(clk, reset_n) begin
if reset_n = '0' then
    reg <= (OTHERS => '0');
elsif (clk'EVENT AND clk = '1') then
    IF reset_s = '1' then
        reg <= (OTHERS => '0');
    ELSIF load = '1' THEN
        reg <= parin; --(OTHERS => '1'); question de nico
    ELSIF enable = '1' THEN
        IF dir = '0' THEN
            reg <= reg(14 downto 0) & serin;
        ELSE
            reg <= serin & reg(15 downto 1);
        END IF;
    END IF;
end if;
end process;

dout <= reg;

end Behavioral;
