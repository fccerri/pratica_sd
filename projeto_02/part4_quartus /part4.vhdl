library IEEE;
use IEEE.std_logic_1164.all;

entity part4 is
    port(
        Key0: in STD_LOGIC;
        Sw0: in STD_LOGIC;
        Sw1: in STD_LOGIC;
        disp0: out STD_LOGIC_VECTOR (6 downto 0);
        disp1: out STD_LOGIC_VECTOR (6 downto 0);
        disp2: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity part4;

architecture Behaviour of part4 is
    component cont_p4 is
        port (
            Clk: in STD_LOGIC;
            T: in STD_LOGIC;
            Q: out STD_LOGIC_VECTOR (1 downto 0);
            clear: in STD_LOGIC
        );
    end component cont_p4;
    component display_p4 is
        port(
            in_d0: in STD_LOGIC_VECTOR (1 downto 0);
            in_d1: in STD_LOGIC_VECTOR (1 downto 0);
            in_d2: in STD_LOGIC_VECTOR (1 downto 0);
            out_d0: out STD_LOGIC_VECTOR (6 downto 0);
            out_d1: out STD_LOGIC_VECTOR (6 downto 0);
            out_d2: out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component display_p4;
    signal output: STD_LOGIC_VECTOR (1 downto 0);
begin
    c: cont_p4
    port map(
        Clk => Key0,
        T => Sw0,
        Q => output,
        Clear => Sw1
    );
    d: display_p4
    port map(
        in_d0 => output,
        in_d1 => output,
        in_d2 => output,
        out_d0 => disp0,
        out_d1 => disp1,
        out_d2 => disp2
    );
end architecture Behaviour;