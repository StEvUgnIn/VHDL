----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2018 19:48:50
-- Design Name: 
-- Module Name: CMP - Behavioral
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

entity CMP is
    Port ( in1 : in STD_LOGIC_VECTOR (7 downto 0);
           in2 : in STD_LOGIC_VECTOR (7 downto 0);
           cmp : out std_logic_vector (2 downto 0));
end CMP;

architecture Behavioral of CMP is
begin

process(in1, in2)
begin
    if in1 = in2 then
    cmp <= "001";
    elsif in1 < in2 then
    cmp <= "100";
    elsif in1 > in2 then
    cmp <= "010";
    end if;
end process;

end Behavioral;
