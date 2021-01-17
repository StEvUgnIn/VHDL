----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 13:38:55
-- Design Name: 
-- Module Name: AD_4bit - Behavioral
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

entity AD_4bit is
    Port ( nombre_A : in STD_LOGIC_VECTOR (4 downto 0);
           nombre_B : in STD_LOGIC_VECTOR (4 downto 0);
           carry_in : in STD_LOGIC;
           carry_out : inout STD_LOGIC;
           somme : out STD_LOGIC_VECTOR (3 downto 0));
end AD_4bit;



architecture Structural of AD_4bit is
    signal loc_carry_in : std_logic := carry_in;
    signal loc_carry_out : std_logic := carry_out;
    
    component AD_C
    port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        CO : in STD_LOGIC;
        CI : out STD_LOGIC;
        S : out STD_LOGIC
    );
    end component;
begin -- relier les entrees aux sorties

first: AD_C
port map (
    nombre_A(0) => A,
    nombre_B(0) => B,
    somme(0) => s
	loc_carry_in  => CO,
	loc_carry_out => CI;
    );

second: AD_C
port map (
    nombre_A(1) => A,
    nombre_B(1) => B,
    somme(1) => s,
	carry_in  => CO,
	carry_out => CI
    );
    
third: AD_C
port map (
	nombre_A(2) => A,
	nombre_B(2) => B,
	somme(2) => s,
	carry_in  => CO,
	carry_out => CI
	);

fourth: AD_C
port map (
    nombre_A(3) => A,
    nombre_B(3) => B,
    somme(3) => s,
	carry_in  => CO,
	carry_out => CI
    );

end Structural;
