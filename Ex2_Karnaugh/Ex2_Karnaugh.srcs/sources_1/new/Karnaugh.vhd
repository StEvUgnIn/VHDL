----------------------------------------------------------------------------------
-- Create Date: 26.09.2018 14:31:53
-- Module Name: Karnaugh - Behavioral
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Karnaugh is
    Port ( d : in STD_LOGIC;
           c : in STD_LOGIC;
           b : in STD_LOGIC;
           a : in STD_LOGIC;
           ya : out STD_LOGIC;
           yb : out STD_LOGIC;
           yc : out STD_LOGIC;
           yd : out STD_LOGIC;
           ye : out STD_LOGIC;
           yf : out STD_LOGIC;
           yg : out STD_LOGIC);
end Karnaugh;

architecture Behavioral of Karnaugh is

begin

ya <= d or (a and c) or (a and b) or (not(a) and not(c));
yb <= not(c) or (not(a) and not(b)) or (a and b);
yc <= c or not(b) or a;
yd <= d or (b and not(c)) or (b and not(a)) or (not(c) and not(a)) or ((c and a) and not(b));

end Behavioral;
