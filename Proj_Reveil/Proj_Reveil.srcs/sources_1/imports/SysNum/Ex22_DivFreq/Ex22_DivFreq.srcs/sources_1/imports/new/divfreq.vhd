----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2018 13:00:45
-- Design Name: 
-- Module Name: bascule - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Ecrire la description VHDL comportementale synthétisable d'un diviseur de fréquence programmable de 2 à 256, 
-- avec reset asynchrone. Le signal de sortie doit avoir une impulsion d'une largeur d'une période de clk.
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divfreq is
    Port ( clk      : in STD_LOGIC;
           reset_n  : in STD_LOGIC;
           div      : out STD_LOGIC);  -- largeur de periode clk
end divfreq;

architecture Behavioral of divfreq is

signal counter : std_logic_vector (17 downto 0); -- diviseur de fréquence de 2 a 2^18 bits

begin

    p1:PROCESS (clk, reset_n) BEGIN
    IF reset_n = '0' THEN --reset asynchrone actif bas
        counter <= "111101000010001111";
        div     <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN --flanc montant du signal clk
        IF UNSIGNED(counter) = 0 THEN -- divise par counter + 1 => donc represente par 2 a 256
            counter <= "111101000010001111";
            div     <= '1';
        ELSE
            counter <= std_logic_vector (unsigned(counter) - 1);
            div     <= '0';
        END IF;
    END IF;
    END process;

end Behavioral;
