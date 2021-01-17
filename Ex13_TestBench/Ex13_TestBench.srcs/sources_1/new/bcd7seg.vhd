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

entity bcd7seg is
    Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);  -- entrees   4 bits
           aff : out STD_LOGIC_VECTOR (6 downto 0); -- affichage 7 segments (bits)
           aff_enable : out STD_LOGIC);             -- activation affichage seg_7
end bcd7seg;

architecture Behavioral of bcd7seg is
    constant c_zero   : std_logic_vector (3 downto 0) := "0000";
    constant c_un     : std_logic_vector (3 downto 0) := "0001";
    constant c_deux   : std_logic_vector (3 downto 0) := "0010";
    constant c_trois  : std_logic_vector (3 downto 0) := "0011";
    constant c_quatre : std_logic_vector (3 downto 0) := "0100";
    constant c_cinq   : std_logic_vector (3 downto 0) := "0101";
    constant c_six    : std_logic_vector (3 downto 0) := "0110";
    constant c_sept   : std_logic_vector (3 downto 0) := "0111";
    constant c_huit   : std_logic_vector (3 downto 0) := "1000";
    constant c_neuf   : std_logic_vector (3 downto 0) := "1001";
    														      --gfedcba
    constant c_zero_out        : std_logic_vector(6 downto 0) := "0111111";
    constant c_un_out          : std_logic_vector(6 downto 0) := "0000110";
    constant c_deux_out        : std_logic_vector(6 downto 0) := "1011011";
    constant c_trois_out       : std_logic_vector(6 downto 0) := "1001111";
    constant c_quatre_out      : std_logic_vector(6 downto 0) := "1100110";
    constant c_cinq_out        : std_logic_vector(6 downto 0) := "1101101";
    constant c_six_out         : std_logic_vector(6 downto 0) := "1111100";
    constant c_sept_out        : std_logic_vector(6 downto 0) := "0000111";
    constant c_huit_out        : std_logic_vector(6 downto 0) := "1111111";
    constant c_neuf_out        : std_logic_vector(6 downto 0) := "1101111";
    constant c_err_out         : std_logic_vector(6 downto 0) := "-------";
begin
aff_enable <= '1';

WITH BCD SELECT
    aff <= c_zero_out   WHEN c_zero,
           c_un_out     WHEN c_un,
           c_deux_out   WHEN c_deux,
           c_trois_out  WHEN c_trois,             
           c_quatre_out WHEN c_quatre,
           c_cinq_out   WHEN c_cinq,
           c_six_out    WHEN c_six,
           c_sept_out   WHEN c_sept,
           c_huit_out   WHEN c_huit,
           c_neuf_out   WHEN c_neuf,
           "-------"    WHEN OTHERS;
                           
end Behavioral;