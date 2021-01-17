----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2018 15:31:04
-- Design Name: 
-- Module Name: hierarchie_1 - Behavioral
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

entity hierarchie_1 is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           in3 : in STD_LOGIC;
           and3 : out STD_LOGIC; -- fonction ET à 3 entrees in1, in2, in3
           or3 : out STD_LOGIC); -- fonction OU à 3 entrées in1, in2, in3
end hierarchie_1;

architecture Behavioral of hierarchie_1 is
     
begin
    and3 <= in1 and in2 and in3;
    or3  <= in1 or  in2 or  in3;
end Behavioral;
