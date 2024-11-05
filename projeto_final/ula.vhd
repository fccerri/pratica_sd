library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ula is
    port (
        OP: in STD_LOGIC_VECTOR (3 downto 0);
        A: in STD_LOGIC_VECTOR (7 downto 0);
        B: in STD_LOGIC_VECTOR (7 downto 0);
        R: buffer STD_LOGIC_VECTOR (7 downto 0);
        Zero: out STD_LOGIC := '0';
        Sinal: out STD_LOGIC := '0';
        Carry: out STD_LOGIC := '0';
        Overflow: out STD_LOGIC := '0'
    );
end entity;

architecture Behaviour of ula is

    component full_add is
        port (
            X: in STD_LOGIC;
            Y: in STD_LOGIC; 
            Ci: in STD_LOGIC;
            S: out STD_LOGIC;
            Co: out STD_LOGIC
        );
    end component;

    signal Cout: STD_LOGIC;
    signal Num1: STD_LOGIC_VECTOR (7 downto 0);
    signal Num2: STD_LOGIC_VECTOR (7 downto 0);
    signal Cin: STD_LOGIC_VECTOR (7 downto 0);
    signal Solution: STD_LOGIC_VECTOR (7 downto 0);
    
begin

    Cin(0) <= OP(0);

    Num1 <= A;

    Num2 <= not B when OP="0001" else 
            B;

    FA1: full_add port map(X => Num1(0), Y => Num2(0), Ci => Cin(0), S => Solution(0), Co => Cin(1));
    FA2: full_add port map(X => Num1(1), Y => Num2(1), Ci => Cin(1), S => Solution(1), Co => Cin(2));
    FA3: full_add port map(X => Num1(2), Y => Num2(2), Ci => Cin(2), S => Solution(2), Co => Cin(3));
    FA4: full_add port map(X => Num1(3), Y => Num2(3), Ci => Cin(3), S => Solution(3), Co => Cin(4));
    FA5: full_add port map(X => Num1(4), Y => Num2(4), Ci => Cin(4), S => Solution(4), Co => Cin(5));
    FA6: full_add port map(X => Num1(5), Y => Num2(5), Ci => Cin(5), S => Solution(5), Co => Cin(6));
    FA7: full_add port map(X => Num1(6), Y => Num2(6), Ci => Cin(6), S => Solution(6), Co => Cin(7));
    FA8: full_add port map(X => Num1(7), Y => Num2(7), Ci => Cin(7), S => Solution(7), Co => Cout);

    R <= Solution when OP="0000" or OP="0001" else
         A and B when OP="0010" else
         A or B when OP="0011" else
         not A when OP="0100";

    Zero <= '1' when (OP="0000" or OP="0001" or OP="0010" or OP="0011" or OP="0100") and R="00000000";

    Sinal <= R(7) when (OP="0000" or OP="0001" or OP="0010" or OP="0011" or OP="0100");

    Carry <= Cin(7) when OP="0000" or OP="0001";

    Overflow <= Cin(7) xor Cout when OP="0000" or OP="0001";
    
end architecture Behaviour;
