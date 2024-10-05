library IEEE;
use IEEE.std_logic_1164.all;

entity part3 is
    port (
        Key0: in STD_LOGIC;
        Sw0: in STD_LOGIC;
        Sw1: in STD_LOGIC;
        disp: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity part3;

architecture Behaviour of part3 is
    component contfreq is
        port (
            Clk: in STD_LOGIC;
            T: in STD_LOGIC;
            Q: out STD_LOGIC_VECTOR (3 downto 0);
            clear: in STD_LOGIC
        );
    end component contfreq;
    component display7seg is
        port(
            in_disp: in STD_LOGIC_VECTOR (3 downto 0);
            out_disp: out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component display7seg;
    signal cont: STD_LOGIC_VECTOR (3 downto 0);
begin
    c: contfreq
    port map(
        Clk => Key0,
        T => Sw0,
        Q => cont,
        clear => Sw1
    );
    d: display7seg
    port map(
        in_disp => cont,
        out_disp => disp
    );
end architecture Behaviour;