----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2019 17:35:30
-- Design Name: 
-- Module Name: muxhr - Behavioral
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

entity muxhr is
    Port ( hr : in STD_LOGIC;
           blink : in std_logic;
           h : in std_logic_vector (3 downto 0);
           a : in std_logic_vector (3 downto 0);
           mux : out std_logic_vector (3 downto 0));
end muxhr;

architecture Behavioral of muxhr is

begin

mux <=  (OTHERS => '0') when blink='1' -- quand blink est sur 1 alors éteint BCD
        else a when hr = '1' 
        else h;

end Behavioral;
