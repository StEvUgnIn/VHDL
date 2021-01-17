library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Equations is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           S : out STD_LOGIC;
           Y : out STD_LOGIC);
end Equations;

architecture Behavioral of Equations is

begin

S <= (A OR NOT(B)) AND (A AND NOT(C));
Y <= (NOT(A) AND B AND C) OR (A AND B AND C) OR (A AND B AND NOT(C));

end Behavioral;
