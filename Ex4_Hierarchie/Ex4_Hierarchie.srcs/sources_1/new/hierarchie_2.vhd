----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2018 15:31:04
-- Design Name: 
-- Module Name: hierarchie_2 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hierarchie_2 is
    Port ( sel : in STD_LOGIC;      -- le signal sel sélectionne si c'est and3 ou or3 qui sort sur out1
           and3 : in STD_LOGIC;
           or3 : in STD_LOGIC;
           selout : out STD_LOGIC;  -- Le signal sel_out est équivalent au signal sel
           out1 : out STD_LOGIC);
end hierarchie_2;

architecture Behavioral of hierarchie_2 is
-- constants
    constant c_and : std_logic := '1';
    constant c_or  : std_logic := '0';
begin
    out1   <= and3 when sel = c_and else or3;
    selout <= sel;
end Behavioral;
