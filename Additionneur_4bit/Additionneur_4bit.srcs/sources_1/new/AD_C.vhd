----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2018 13:38:55
-- Design Name: 
-- Module Name: AD_C - Behavioral
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

entity AD_C is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           CO : in STD_LOGIC;
           CI : out STD_LOGIC;
           S : out STD_LOGIC);
end AD_C;

architecture Behavioral of AD_C is

begin -- multiplexeur

S <= A when CO = '0' else B when CO = '1' else '-';

end Behavioral;
