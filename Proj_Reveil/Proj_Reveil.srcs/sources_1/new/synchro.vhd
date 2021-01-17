----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 15:46:59
-- Design Name: 
-- Module Name: synchro - Behavioral
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

entity synchro is -- Synchronisation et détection des flancs d'un signal externe asynchrone
    Port ( clk : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            hr : in STD_LOGIC;
            inc : in STD_LOGIC;
            dec : in STD_LOGIC;
            ok : in STD_LOGIC;
            hrsc : out STD_LOGIC;
            incsc : out STD_LOGIC;
            decsc : out STD_LOGIC;
            oksc : out STD_LOGIC);
end synchro;

architecture Behavioral of synchro is

component synchronisation
    Port ( clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           entree_asynchrone : in STD_LOGIC;
           sortie_synchrone : out STD_LOGIC);
end component;

BEGIN

synchro_hr : synchronisation
Port Map (
    clk => clk,
    reset_n => reset_n, 
    entree_asynchrone => hr,
    sortie_synchrone => hrsc
);

synchro_inc : synchronisation
Port Map (
    clk => clk,
    reset_n => reset_n, 
    entree_asynchrone => inc,
    sortie_synchrone => incsc
);

synchro_dec : synchronisation
Port Map (
    clk => clk,
    reset_n => reset_n, 
    entree_asynchrone => dec,
    sortie_synchrone => decsc
);

synchro_ok : synchronisation
Port Map (
    clk => clk,
    reset_n => reset_n, 
    entree_asynchrone => ok,
    sortie_synchrone => oksc
);

end Behavioral;
