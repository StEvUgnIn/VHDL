----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 11:25:06
-- Design Name: 
-- Module Name: affichage - Behavioral
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

entity affichage is
    Port ( clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           hr : in STD_LOGIC;
           blink : in STD_LOGIC;
           hhd : in std_logic_vector (3 downto 0);
           hhu : in std_logic_vector (3 downto 0);
           hmd : in std_logic_vector (3 downto 0);
           hmu : in std_logic_vector (3 downto 0);
           ahd : in std_logic_vector (3 downto 0);
           ahu : in std_logic_vector (3 downto 0);
           amd : in std_logic_vector (3 downto 0);
           amu : in std_logic_vector (3 downto 0);
           BCD : out STD_LOGIC_VECTOR (6 downto 0);
           aff_enable : out STD_LOGIC_VECTOR(3 downto 0));
end affichage;

architecture Behavioral of affichage is

subtype t_state is std_logic_vector (3 downto 0);

--signal state : t_state;

signal hd : t_state;
signal hu : t_state;
signal md : t_state;
signal mu : t_state;

signal digit : t_state; -- pour affichage BCD selectionne
signal freq400hz : std_logic;
signal reg   : t_state;  -- selecteur de canal

component divfreq
    Port ( clk      : in STD_LOGIC;
           reset_n  : in STD_LOGIC;
           div      : out STD_LOGIC);  -- largeur de periode clk
end component;

component regdec
    Port ( clk     : in STD_LOGIC;
           reset_n : in STD_LOGIC; -- synchrone actif haut
           serin  : in std_logic; -- registre d'entree
           dout  : out std_logic_vector (3 downto 0)); -- registre de sortie 4 bits 
end component;

component enable_aff
    Port ( aff : in std_logic_vector (3 downto 0); -- autorisation a afficher
           aff_enable : out STD_LOGIC_VECTOR(3 downto 0)); -- activation affichage seg_7
end component;

component bcd7seg
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0); -- entrees   4 bits
          BCD : out STD_LOGIC_VECTOR (6 downto 0)); -- affichage 7 segments (bits)
end component;

component muxhr
    Port ( hr : in STD_LOGIC;
           blink : in STD_LOGIC;
           h : in std_logic_vector (3 downto 0);
           a : in std_logic_vector (3 downto 0);
           mux : out std_logic_vector (3 downto 0));
end component;

component mux4a4
    Port ( ina : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           inb : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           inc : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           ind : in STD_LOGIC_VECTOR (3 downto 0);  -- canal de 4 bit
           sel : in STD_LOGIC_VECTOR (3 downto 0);  -- selecteur de canal
           mux : out STD_LOGIC_VECTOR (3 downto 0));-- sortie de multiplexage 4 a 4
end component;

begin

genfreq400hz : divfreq
Port Map (
    clk => clk,
    reset_n => reset_n,
    div => freq400hz
);

shiftr: regdec
Port Map (
    --enable => freq400hz,
    clk => clk,
    reset_n => reset_n,
    serin => freq400hz,
    dout => reg
);

muxhd: muxhr
Port Map (
    hr => hr,
    blink => blink,
    h => hhd,
    a => ahd,
    mux => hd
);

muxhu: muxhr
Port Map (
    hr => hr,
    blink => blink,
    h => hhu,
    a => ahu,
    mux => hu
);

muxmd: muxhr
Port Map (
    hr => hr,
    blink => blink,
    h => hmd,
    a => amd,
    mux => md
);

muxmu: muxhr
Port Map (
    hr => hr,
    blink => blink,
    h => hmu,
    a => amu,
    mux => mu
);

muxbcd: mux4a4 
Port Map (
    ina => hd,
    inb => hu,
    inc => md,
    ind => mu,
    sel => reg,
    mux => digit 
);

enable : enable_aff
Port Map (
    aff => reg,
    aff_enable => aff_enable
);

display: bcd7seg
Port Map (
    digit => digit,
    BCD => BCD
);

end Behavioral;
