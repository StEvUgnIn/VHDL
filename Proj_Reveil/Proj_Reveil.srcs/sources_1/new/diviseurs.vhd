----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 15:46:59
-- Design Name: 
-- Module Name: diviseurs - Behavioral
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

entity diviseurs is
    Port ( clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           clkmin : out std_logic;
           clk4hz : out std_logic);
end diviseurs;

architecture Behavioral of diviseurs is
    
    signal loc_min : std_logic;
    signal loc_4hz : std_logic;
    
    component divmin -- periode 60s
        Port ( clk      : in STD_LOGIC;
               reset_n  : in STD_LOGIC;
               div      : out STD_LOGIC);  -- largeur de periode clk
    end component;
    
    component div4hz -- frequence 4 Hz
        Port ( clk      : in STD_LOGIC;
               reset_n  : in STD_LOGIC;
               div      : out STD_LOGIC);  -- largeur de periode clk
    end component;
begin

fmin: divmin
Port Map (
    clk => clk,
    reset_n => reset_n,
    div => loc_min
);

f4hz : div4hz
Port Map (
    clk => clk,
    reset_n => reset_n,
    div => loc_4hz
);

clkmin <= loc_min;
clk4hz <= loc_4hz;

end Behavioral;
