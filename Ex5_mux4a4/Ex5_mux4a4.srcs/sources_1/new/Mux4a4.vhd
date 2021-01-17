----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2018 16:53:50
-- Design Name: 
-- Module Name: Mux4a4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- réalise la fonction logique multiplexeur de 4 canaux de 4 bits (ina, inb ,inc et ind) en un canal de 4 bits (mux)
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4a4 is
    Port ( ina : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           inb : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           inc : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           ind : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           sel : in STD_LOGIC_VECTOR (1 downto 0);  -- selecteur de canal
           mux : out STD_LOGIC_VECTOR (3 downto 0));-- sortie de multiplexage 4 a 4
end Mux4a4;

architecture Behavioral of Mux4a4 is
    constant c_a : std_logic_vector (1 downto 0) := "00";
    constant c_b : std_logic_vector (1 downto 0) := "01";
    constant c_c : std_logic_vector (1 downto 0) := "10";
    constant c_d : std_logic_vector (1 downto 0) := "11";

begin

with sel select
    mux <= ina    when c_a,
           inb    when c_b,
           inc    when c_c,
           ind    when c_d,
           "----" when others;

end Behavioral;
