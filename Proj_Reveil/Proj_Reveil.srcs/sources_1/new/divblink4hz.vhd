----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2019 20:44:38
-- Design Name: 
-- Module Name: div4hz - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div4hz is
        Port ( clk      : in STD_LOGIC;
               reset_n  : in STD_LOGIC;
               div      : out STD_LOGIC);  -- largeur de periode clk
end div4hz;

architecture Behavioral of div4hz is

signal q : std_logic;
signal counter : std_logic_vector (24 downto 0); -- diviseur de fréquence de 2 a 2^25 bits

begin

    p1:PROCESS (clk, reset_n) BEGIN
    IF reset_n = '0' THEN --reset asynchrone actif bas
        counter <= "1011111010111100000111111";
        q     <= '0';
    ELSIF (clk'EVENT AND clk = '1') THEN --flanc montant du signal clk
        IF UNSIGNED(counter) = 0 THEN -- divise par counter + 1 => donc represente par 2 a 256
            counter <= "1011111010111100000111111";
            q     <= not (q); -- rapport cyclique 50 pour cents
        ELSE
            counter <= std_logic_vector (unsigned(counter) - 1);
            q     <= '0';
        END IF;
    END IF;
    END process;
    
    div <= q;
    
end Behavioral;
