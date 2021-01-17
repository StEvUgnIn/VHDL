----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2018 13:14:26
-- Design Name: 
-- Module Name: BCD_HDL - Behavioral
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

entity BCD_HDL is
    Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
           aff2_enable : out STD_LOGIC;
           ya : out STD_LOGIC;
           yb : out STD_LOGIC;
           yc : out STD_LOGIC;
           yd : out STD_LOGIC;
           ye : out STD_LOGIC;
           yf : out STD_LOGIC;
           yg : out STD_LOGIC);
end BCD_HDL;

architecture Behavioral of BCD_HDL is

begin 
aff2_enable <= '1';

ya <= '0' when BCD="0001" OR BCD="0100" OR BCD="0110" ELSE '1';
yb <= '0' when BCD="0101" OR BCD="0110" ELSE '1';
yc <= '0' when BCD="0010" ELSE '1';
yd <= '0' when BCD="0001" OR BCD="0100" OR BCD="0111" ELSE '1';
ye <= '0' when BCD="0001" OR BCD="0011" OR BCD="0100" OR BCD="0101" OR BCD="0111" OR BCD="1001" ELSE '1';
yf <= '0' when BCD="0001" OR BCD="0010" OR BCD="0011" OR BCD="0111" ELSE '1';
yg <= '0' when BCD="0000" OR BCD="0001" OR BCD="0111" ELSE '1';
end Behavioral;
