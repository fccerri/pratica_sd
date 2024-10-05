library IEEE;
use IEEE.std_logic_1164.all;

entity part1 is
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
end entity part1;

architecture Behaviour of part1 is
signal output, output1, output2, output3, output4, output5, output6, output7, enable1, enable2, enable3, enable4, enable5, enable6, enable7: STD_LOGIC;
component fft is
    port (
        Clk: in STD_LOGIC;
        T: in STD_LOGIC;
        Q: out STD_LOGIC;
        Clear: in STD_LOGIC
    );
end component fft;
begin
    f0: fft
    port map (
        Clk => Clk,
        T => T,
        Q => output,
        Clear => Clear
    );
    enable1 <= T and output;
    f1: fft
    port map (
        Clk => Clk,
        T => enable1,
        Q => output1,
        Clear => Clear
    );
    enable2 <= enable1 and output1;
    f2: fft
    port map (
        Clk => Clk,
        T => enable2,
        Q => output2,
        Clear => Clear
    );
    enable3 <= enable2 and output2;
    f3: fft
    port map (
        Clk => Clk,
        T => enable3,
        Q => output3,
        Clear => Clear
    );
    enable4 <= enable3 and output3;
    f4: fft
    port map (
        Clk => Clk,
        T => enable4,
        Q => output4,
        Clear => Clear
    );
    enable5 <= enable4 and output4;
    f5: fft
    port map (
        Clk => Clk,
        T => enable5,
        Q => output5,
        Clear => Clear
    );
    enable6 <= enable5 and output5;
    f6: fft
    port map (
        Clk => Clk,
        T => enable6,
        Q => output6,
        Clear => Clear
    );
    enable7 <= enable6 and output6;
    f7: fft
    port map (
        Clk => Clk,
        T => enable7,
        Q => output7,
        Clear => Clear
    );
        Q0 <= output;
        Q1 <= output1;
        Q2 <= output2;
        Q3 <= output3;
        Q4 <= output4;
        Q5 <= output5;
        Q6 <= output6;
        Q7 <= output7;
end architecture;