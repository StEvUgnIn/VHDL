library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- machine d'etat du reveil numerique
entity FSM is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           hr  : in std_logic;
           dec : in std_logic;
           inc : in std_logic;
           ok  : in std_logic;
           sw  : in std_logic_vector (15 downto 0);
           buzzer : out std_logic;
           bcd : out std_logic_vector (6 downto 0);           
           aff_enable : out std_logic_vector (3 downto 0));                      
end FSM;

architecture Behavioral of FSM is

--Declare type, subtype
subtype t_state is	std_logic_vector(3 downto 0);
subtype t_mud is	std_logic_vector(1 downto 0);
   
--Declare constantes
constant c_heure  : t_state := "0000";
constant c_load   : t_state := "0001";
constant c_alarm  : t_state := "0010";
constant c_ring   : t_state := "0011";
constant c_stop   : t_state := "0100";
constant c_a_set  : t_state := "0101";
constant c_blk_hd : t_state := "0110";
constant c_blk_hu : t_state := "0111";
constant c_blk_md : t_state := "1000";
constant c_blk_mu : t_state := "1001";
constant c_rcount : t_state := "1010";
constant c_ccount : t_state := "1011";

constant c_hd     : t_mud   := "00";
constant c_hu     : t_mud   := "01";
constant c_md     : t_mud   := "10";
constant c_mu     : t_mud   := "11";

--Declare signaux
signal state :	t_state;
signal mud : std_logic_vector (1 downto 0);

signal ahd : t_state;
signal ahu : t_state;
signal amd : t_state;
signal amu : t_state;
signal hhd : t_state;
signal hhu : t_state;
signal hmd : t_state;
signal hmu : t_state;

-- entrees synchrones
signal hrsc : STD_LOGIC;
signal incsc : STD_LOGIC;
signal decsc : STD_LOGIC;
signal oksc : STD_LOGIC;

signal ebl_buzzer : std_logic; -- set alarm clock
signal clkmin : STD_LOGIC;
signal clk4hz : STD_LOGIC;

--signaux de sortie
signal loc_buzzer   : std_logic;

component affichage
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
           -- biled1 : out std_logic;
           -- biled2 : out std_logic;
           -- biled3 : out std_logic;
end component;

component synchro
    Port (  clk : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            hr : in STD_LOGIC;
            inc : in STD_LOGIC;
            dec : in STD_LOGIC;
            ok : in STD_LOGIC;
            hrsc : out STD_LOGIC;
            incsc : out STD_LOGIC;
            decsc : out STD_LOGIC;
            oksc : out STD_LOGIC);
end component;

component diviseurs
    Port (  clk : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            clkmin : out std_logic;
            clk4hz : out std_logic);
end component;

component heure
    Port (  clk : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            enable : in STD_LOGIC;
            inc : in STD_LOGIC;
            dec : in STD_LOGIC;
            hd : out STD_LOGIC_VECTOR (3 downto 0);
            hu : out STD_LOGIC_VECTOR (3 downto 0);
            md : out STD_LOGIC_VECTOR (3 downto 0);
            mu : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component reveil
    Port (  clk : in  STD_LOGIC;
            reset_n : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            inc : in std_logic;
            dec : in std_logic;
            hd : out std_logic_vector (3 downto 0);           
            hu : out std_logic_vector (3 downto 0);           
            md : out std_logic_vector (3 downto 0);           
            mu : out std_logic_vector (3 downto 0));
end component;

component compare
    Port ( hhd : in STD_LOGIC_VECTOR (3 downto 0);
           hhu : in STD_LOGIC_VECTOR (3 downto 0);
           hmd : in STD_LOGIC_VECTOR (3 downto 0);
           hmu : in STD_LOGIC_VECTOR (3 downto 0);
           ahd : in STD_LOGIC_VECTOR (3 downto 0);
           ahu : in STD_LOGIC_VECTOR (3 downto 0);
           amd : in STD_LOGIC_VECTOR (3 downto 0);
           amu : in STD_LOGIC_VECTOR (3 downto 0);
           cmp : out STD_LOGIC);
end component;

begin

aff: affichage
Port Map (
    clk => clk,
    reset_n => reset_n,
    hr => hrsc,
    blink => clk4hz,
    hhd => hhd,
    hhu => hhu,
    hmd => hmd, 
    hmu => hmu,
    ahd => ahd, 
    ahu => ahu,
    amd => amd, 
    amu => amu,
    BCD => BCD,
    aff_enable => aff_enable
);

div: diviseurs
Port Map (
    clk => clk,
    reset_n => reset_n,
    clkmin => clkmin,
    clk4hz => clk4hz
);

h: heure 
Port Map (
    clk => clk,
    reset_n => reset_n,
    enable => clkmin,
    inc => incsc,
    dec => decsc,
    hd => hhd,
    hu => hhu,
    md => hmd,
    mu => hmu
);

a: reveil
Port Map (
    clk => clk,
    reset_n => reset_n,
    enable => clkmin,
    inc => incsc,
    dec => decsc,
    hd => ahd,
    hu => ahu,
    md => amd,
    mu => amu
);

sync: synchro
Port Map (
    clk => clk,
    reset_n => reset_n,
    hr => hr,
    inc => inc,
    dec => dec,
    ok => ok,
    hrsc => hrsc,
    incsc => incsc,
    decsc => decsc,
    oksc => oksc
);

cmp: compare
Port Map (
    hhd => hhd,
    hhu => hhu,
    hmd => hmd, 
    hmu => hmu,
    ahd => ahd, 
    ahu => ahu,
    amd => amd, 
    amu => amu,
    cmp => loc_buzzer
);

P1:PROCESS(clk, reset_n) BEGIN
	IF reset_n = '0' THEN
	    hhd <= (OTHERS => '0');
        hhu <= (OTHERS => '0');
        hmd <= (OTHERS => '0'); 
        hmu <= (OTHERS => '0');
        ahd <= (OTHERS => '0'); 
        ahu <= (OTHERS => '0');
        amd <= (OTHERS => '0'); 
        amu <= (OTHERS => '0');
        ebl_buzzer <= '0';
        buzzer <= '0';
		state <= c_Heure;
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE state IS
			WHEN c_Heure =>
                IF hrsc = '1' THEN state <= c_alarm;
                ELSIF incsc = '1' THEN state <= c_load; 
                ELSIF decsc = '1' THEN state <= c_a_set; 
                ELSIF oksc = '1' THEN state <= c_blk_hd;
                ELSE state <= c_Heure;
                END IF;
            WHEN c_load =>
                IF hrsc = '0' THEN
                    hhd <= sw(15 downto 12);
                    hhu <= sw(11 downto  8);
                    hmd <= sw( 7 downto  4);
                    hmu <= sw( 3 downto  0);
                ELSIF hrsc = '1' THEN
                    ahd <= sw(15 downto 12);
                    ahu <= sw(11 downto  8);
                    amd <= sw( 7 downto  4);
                    amu <= sw( 3 downto  0);
                END IF;
                state <= c_Heure;
            WHEN c_alarm =>
                IF incsc = '1' THEN state <= c_load;
                ELSIF decsc = '1' THEN state <= c_a_set;
                ELSIF oksc = '1' THEN state <= c_blk_hd;
                ELSIF hrsc = '1' THEN state <= c_alarm;
                ELSE state <= c_Heure;
                END IF;
            WHEN c_ring =>
                IF hrsc = '1' or incsc = '1' or decsc = '1' or oksc = '1' THEN
                    state <= c_stop;
                ELSE 
                buzzer <= '1';
                state <= c_ring;
                END IF;
            WHEN c_stop =>
                buzzer <= '0';
                state <= c_Heure;
            WHEN c_a_set =>
                ebl_buzzer <= not ebl_buzzer;
                state <= c_Heure;
            WHEN c_blk_hd =>
                mud <= c_hd;
                IF oksc = '1' THEN
                    state <= c_blk_hu;
                ELSIF incsc = '1' THEN
                    state <= c_ccount;
                ELSIF decsc = '1' THEN
                    state <= c_rcount;
                ELSE state <= c_blk_hd;
                END IF;
            WHEN c_blk_hu =>
                mud <= c_hu;
                IF oksc = '1' THEN
                    state <= c_blk_md;
                ELSIF incsc = '1' THEN
                    state <= c_ccount;
                ELSIF decsc = '1' THEN
                    state <= c_rcount;
                ELSE state <= c_blk_hu;
                END IF;
            WHEN c_blk_md =>
                mud <= c_md;
                IF oksc = '1' THEN
                    state <= c_blk_mu;
                ELSIF incsc = '1' THEN
                    state <= c_ccount;
                ELSIF decsc = '1' THEN
                    state <= c_rcount;
                ELSE state <= c_blk_md;
                END IF;
            WHEN c_blk_mu =>
                mud <= c_mu;
                IF oksc = '1' THEN
                    state <= c_Heure;
                ELSIF incsc = '1' THEN
                    state <= c_ccount;
                ELSIF decsc = '1' THEN
                    state <= c_rcount;
                ELSE state <= c_blk_mu;
                END IF;
            WHEN c_rcount =>
                IF decsc = '1' THEN
                    state <= c_rcount;
                ELSIF mud = c_hd THEN
                    state <= c_blk_hd;
                ELSIF mud = c_hu THEN
                    state <= c_blk_hu;
                ELSIF mud = c_md THEN
                    state <= c_blk_md;
                ELSIF mud = c_mu THEN
                    state <= c_blk_mu;
                END IF;
            WHEN c_ccount =>
                IF incsc = '1' THEN
                    state <= c_ccount;
                ELSIF mud = c_hd THEN
                    state <= c_blk_hd;
                ELSIF mud = c_hu THEN
                    state <= c_blk_hu;
                ELSIF mud = c_md THEN
                    state <= c_blk_md;
                ELSIF mud = c_mu THEN
                    state <= c_blk_mu;
                END IF;
			WHEN OTHERS =>
				state <= c_Heure;
		END CASE;
	END IF;
END PROCESS;

--Assignation des sorties combinatoire fonction des etats uniquement (Machine de Moore)
buzzer <= loc_buzzer when ebl_buzzer = '1';

end Behavioral;

