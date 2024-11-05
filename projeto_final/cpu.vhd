library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity cpu is
    port(
        dado: in STD_LOGIC_VECTOR (7 downto 0);
        op: in STD_LOGIC_VECTOR (7 downto 0);
        output: out STD_LOGIC_VECTOR (7 downto 0)
    );
end entity;

architecture Behaviour of cpu is

    component ula is
        port (
            op: in STD_LOGIC_VECTOR (7 downto 0);
            A: in STD_LOGIC_VECTOR (7 downto 0);
            B: in STD_ULOGIC_VECTOR (7 downto 0);
            R: out STD_LOGIC_VECTOR (7 downto 0);
            Zero: out STD_LOGIC := '0';
            Sinal: out STD_LOGIC := '0';
            --Carry: out STD_LOGIC := '0';
            Overflow: out STD_LOGIC := '0'
        );
    end component;

    component uc is
        port (
            op: in STD_LOGIC_VECTOR (7 downto 0);
            pc: out STD_LOGIC_VECTOR (7 downto 0);
            ir: out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component ram256x8 is
        port(
            address: in STD_LOGIC_VECTOR (7 downto 0) := "00000000";
            clock: in STD_LOGIC  := '1';
            data: in STD_LOGIC_VECTOR (7 downto 0);
            wren: in STD_LOGIC ;
            q: out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component pcounter is
        port (
            clk: in STD_LOGIC;
            reset: in STD_LOGIC;
            enable: in STD_LOGIC;
            enable_jmp: in STD_LOGIC;
            jump: in STD_LOGIC_VECTOR (7 downto 0);
            output: buffer integer range 0 to 255
        );
    end component;

    signal Reg1, Reg2, R: STD_LOGIC_VECTOR(7 downto 0);
    signal IR: STD_LOGIC_VECTOR (3 downto 0);
    signal Zero, Sinal, Carry, Overflow: STD_LOGIC;

begin

    process(all)
    begin
        
    end process;

end architecture;