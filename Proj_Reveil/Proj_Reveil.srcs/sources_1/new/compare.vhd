----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 15:46:59
-- Design Name: 
-- Module Name: compare - Behavioral
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

entity compare is
    Port ( hhd : in STD_LOGIC_VECTOR (3 downto 0);
           hhu : in STD_LOGIC_VECTOR (3 downto 0);
           hmd : in STD_LOGIC_VECTOR (3 downto 0);
           hmu : in STD_LOGIC_VECTOR (3 downto 0);
           ahd : in STD_LOGIC_VECTOR (3 downto 0);
           ahu : in STD_LOGIC_VECTOR (3 downto 0);
           amd : in STD_LOGIC_VECTOR (3 downto 0);
           amu : in STD_LOGIC_VECTOR (3 downto 0);
           cmp : out STD_LOGIC);
end compare;

architecture Behavioral of compare is
begin

 cmp <= '1' WHEN hhd = ahd and hhu = ahu and  hmd = amd and  hmd = amu
            ELSE '0'; 

end Behavioral;
