----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2018 15:31:04
-- Design Name: 
-- Module Name: hierarchie_top - Behavioral
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

entity hierarchie_top is
    Port ( sel : in STD_LOGIC;
           in1 : in STD_LOGIC;      -- entree 1 bit
           in2 : in STD_LOGIC;      -- entree 1 bit
           in3 : in STD_LOGIC;      -- entree 1 bit
           selout : out STD_LOGIC;
           out1 : out STD_LOGIC);
end hierarchie_top;

architecture Structural of hierarchie_top is
    SIGNAL loc_and3 : std_logic;
    SIGNAL loc_or3 :  std_logic;
    
    component hierarchie_1 -- titre correspond au fichier 1
    port (
        in1     : in std_logic;      -- entree 1 bit
        in2     : in std_logic;      -- entree 1 bit
        in3     : in std_logic;      -- entree 1 bit
        and3    : inout std_logic;
        or3     : inout std_logic
    );
    end component;
    
    component hierarchie_2 -- titre correspond au fichier 2
        port (
            sel     : in std_logic;
            and3    : in std_logic;
            or3     : in std_logic;
            selout  : out std_logic;
            out1    : out std_logic
        );
        end component;

begin -- relier les entrees aux sorties
    
    first: hierarchie_1 
        Port map (
            in1  => in1,
            in2  => in2,
            in3  => in3,
            and3 => loc_and3,
            or3  => loc_or3);
    
    second: hierarchie_2
        Port map (
            sel  => sel,
            and3 => loc_and3,
            or3  => loc_or3,
          selout => selout,
            out1 => out1);

end Structural;
