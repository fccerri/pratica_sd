library IEEE;
use IEEE.std_logic_1164.all;

entity part1_3 is
    port(
        Key0: in STD_LOGIC;
        Sw0: in STD_LOGIC;
        Sw1: in STD_LOGIC;
        disp0: out STD_LOGIC_VECTOR (6 downto 0);
        disp1: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity part1_3;

architecture Behaviour of part1_3 is
    component part1 is
        port (
            Clk: in STD_LOGIC;
            T: in STD_LOGIC;
            Q0: out STD_LOGIC;
            Q1: out STD_LOGIC;
            Q2: out STD_LOGIC;
            Q3: out STD_LOGIC;
            Q4: out STD_LOGIC;
            Q5: out STD_LOGIC;
            Q6: out STD_LOGIC;
            Q7: out STD_LOGIC;
            Clear: in STD_LOGIC
        );
    end component part1;
    component display7seg is
        port(
            in_disp: in STD_LOGIC_VECTOR (3 downto 0);
            out_disp: out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component display7seg;
    signal output0, output1: STD_LOGIC_VECTOR (3 downto 0);
begin
    c: part1
    port map(
        Clk => Key0,
        T => Sw0,
        Q0 => output0(0),
        Q1 => output0(1),
        Q2 => output0(2),
        Q3 => output0(3),
        Q4 => output1(0),
        Q5 => output1(1),
        Q6 => output1(2),
        Q7 => output1(3),
        Clear => Sw1
    );
    d0: display7seg
    port map(
        in_disp => output0,
        out_disp => disp0
    );
    d1: display7seg
    port map(
        in_disp => output1,
        out_disp => disp1
    );
end architecture Behaviour;