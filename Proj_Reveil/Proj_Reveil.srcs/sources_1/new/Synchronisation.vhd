----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2019 20:05:35
-- Design Name: 
-- Module Name: Synchronisation - synchronisation_B
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

entity synchronisation is
    Port ( clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           entree_asynchrone : in STD_LOGIC;
           sortie_synchrone : out STD_LOGIC);
end synchronisation;

architecture Synchronisation_B of synchronisation is

SIGNAL sync1 : std_logic; --declaration des signaux internes
SIGNAL sync2 : std_logic;
SIGNAL sync3 : std_logic;
SIGNAL sync_pulse : std_logic;

BEGIN

P1:PROCESS(clk, reset_n)
BEGIN
    IF reset_n = '0' THEN 
        sync1 <= '0';
        sync2 <= '0'; 
        sync3 <= '0'; 
        sync_pulse <= '0'; 
    ELSIF clk'EVENT AND clk = '1' THEN 
        sync1 <= entree_asynchrone;
        sync2 <= sync1; 
        sync3 <= sync2;
        sync_pulse <= sync2 AND (NOT sync3);
    END IF; 
END PROCESS;

sortie_synchrone <= sync_pulse;

END Synchronisation_B;