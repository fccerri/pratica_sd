library IEEE;
use IEEE.std_logic_1164.all;

entity part2 is
    port(
        Key0: in STD_LOGIC;
        Sw0: in STD_LOGIC;
        Sw1: in STD_LOGIC;
        disp0: out STD_LOGIC_VECTOR (6 downto 0);
        disp1: out STD_LOGIC_VECTOR (6 downto 0);
        disp2: out STD_LOGIC_VECTOR (6 downto 0);
        disp3: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity part2;

architecture Behaviour of part2 is
    component cont16 is
        port (
            Clk: in STD_LOGIC;
            T: in STD_LOGIC;
            Q: out STD_LOGIC_VECTOR (15 downto 0);
            clear: in STD_LOGIC
        );
    end component cont16;
    component display7seg is
        port(
            in_disp: in STD_LOGIC_VECTOR (3 downto 0);
            out_disp: out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component display7seg;
    signal output: STD_LOGIC_VECTOR (15 downto 0);
    alias output0: STD_LOGIC_VECTOR (3 downto 0) is output(3 downto 0);
    alias output1: STD_LOGIC_VECTOR (3 downto 0) is output(7 downto 4);
    alias output2: STD_LOGIC_VECTOR (3 downto 0) is output(11 downto 8);
    alias output3: STD_LOGIC_VECTOR (3 downto 0) is output(15 downto 12);
begin
    c: cont16
    port map(
        Clk => Key0,
        T => Sw0,
        Clear => Sw1,
        Q => output 
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
    d2: display7seg
    port map(
        in_disp => output2,
        out_disp => disp2
    );
    d3: display7seg
    port map(
        in_disp => output3,
        out_disp => disp3
    );
end architecture Behaviour;