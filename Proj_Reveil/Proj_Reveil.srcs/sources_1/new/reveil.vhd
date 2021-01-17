----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 14:17:23
-- Design Name: 
-- Module Name: heure - Behavioral
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

entity reveil is
    Port (  clk : in  STD_LOGIC;
            reset_n : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            inc : in std_logic;
            dec : in std_logic;
            hd : out std_logic_vector (3 downto 0);           
            hu : out std_logic_vector (3 downto 0);           
            md : out std_logic_vector (3 downto 0);           
            mu : out std_logic_vector (3 downto 0));
end reveil;

architecture Behavioral of reveil is

--Declare type, subtype
subtype t_state is	std_logic_vector(3 DOWNTO 0);

--Declare signaux
signal loc_hd : t_state;
signal loc_hu : t_state;
signal loc_md : t_state;
signal loc_mu : t_state;

component compteurs is 
    Port ( 
        clk : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        enable : in STD_LOGIC;
        inc : in STD_LOGIC;
        dec : in STD_LOGIC;
        hd  : out STD_LOGIC_VECTOR (3 downto 0);
        hu  : out STD_LOGIC_VECTOR (3 downto 0);
        md  : out STD_LOGIC_VECTOR (3 downto 0);
        mu  : out STD_LOGIC_VECTOR (3 downto 0)
        );
end component;

begin

heure: compteurs
    Port Map (
        clk => clk,
        reset_n => reset_n,
        enable => enable,
        inc => inc,
        dec => dec,
        hd => loc_hd,
        hu => loc_hu,
        md => loc_md,
        mu => loc_mu
    );
    
hd <= loc_hd;
hu <= loc_hu;
md <= loc_md;
mu <= loc_mu;

end Behavioral;

