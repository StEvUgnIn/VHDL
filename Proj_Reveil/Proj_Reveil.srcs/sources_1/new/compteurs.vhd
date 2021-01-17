----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 11:38:15
-- Design Name: 
-- Module Name: compteurs - Behavioral
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

entity compteurs is
    Port (  clk : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            enable : in STD_LOGIC;
            inc : in STD_LOGIC;
            dec : in STD_LOGIC;
            hd : out STD_LOGIC_VECTOR (3 downto 0);
            hu : out STD_LOGIC_VECTOR (3 downto 0);
            md : out STD_LOGIC_VECTOR (3 downto 0);
            mu : out STD_LOGIC_VECTOR (3 downto 0));
end compteurs;

architecture Behavioral of compteurs is
--Declare type, subtype
subtype t_state is	std_logic_vector(3 DOWNTO 0);

--Declare signaux
signal loc_hd : t_state;
signal loc_hu : t_state;
signal loc_md : t_state;
signal loc_mu : t_state;

signal car_hd : std_logic; 
signal car_hu : std_logic; 
signal car_md : std_logic; 
signal car_mu : std_logic; 

component counter_BCD is
    Port ( clk 		: in  STD_LOGIC;
           reset_n 	: in  STD_LOGIC;
           enable 	: in  STD_LOGIC;
           -- sel : in std_logic_vector (3 downto 0);
           carry_in : in STD_LOGIC;
           carry_out : out  STD_LOGIC;
           count 	: out  STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

cpt_hd: counter_BCD
    Port Map(
        clk => clk,
        reset_n => reset_n,
        enable => enable,
        -- sel => 
        carry_in => car_hd,
        carry_out => car_mu,
        count => loc_hd
    );

cpt_hu: counter_BCD
    Port Map(
        clk => clk,
        reset_n => reset_n,
        enable => enable,
        carry_in => car_hu,
        carry_out => car_hd,
        count => loc_hu
    );

cpt_md: counter_BCD
    Port Map(
        clk => clk,
        reset_n => reset_n,
        enable => enable,
        carry_in => car_md,
        carry_out => car_hu,
        count => loc_md
    );

cpt_mu: counter_BCD
    Port Map(
        clk => clk,
        reset_n => reset_n,
        enable => enable,
        carry_in => car_mu,
        carry_out => car_md,
        count => loc_mu
    );
    
    mu <= loc_mu;
    md <= loc_md;
    hu <= loc_hu;
    hd <= loc_hd;

end Behavioral;
