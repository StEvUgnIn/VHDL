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
    constant c_dix    : std_logic_vector (3 downto 0) := "1010";    
begin 
aff2_enable <= '1';

ya <= '1' when not (BCD=c_un OR BCD=c_quatre OR BCD=c_six);
yb <= '1' when not (BCD=c_cinq OR BCD=c_six);
yc <= '1' when not (BCD=c_deux);
yd <= '1' when not (BCD=c_un OR BCD=c_quatre OR BCD=c_sept);
ye <= '1' when (BCD=c_zero OR BCD=c_deux OR BCD=c_six OR BCD=c_huit);
yf <= '1' when not (BCD=c_un OR BCD=c_deux OR BCD=c_trois OR BCD=c_sept);
yg <= '1' when not (BCD=c_zero OR BCD=c_un OR BCD=c_sept);

end Behavioral;
