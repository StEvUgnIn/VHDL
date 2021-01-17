----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2019 17:45:20
-- Design Name: 
-- Module Name: enable_aff - Behavioral
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

entity enable_aff is
    Port ( aff : in std_logic_vector (3 downto 0);                              -- autorisation a afficher
           aff_enable : out STD_LOGIC_VECTOR(3 downto 0));   -- activation affichage seg_7
end enable_aff;

architecture Behavioral of enable_aff is

begin
aff_enable <= aff; -- met tous les affichage a aff

end Behavioral;
