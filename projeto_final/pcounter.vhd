library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity pcounter is
    port (
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        enable: in STD_LOGIC;
        enable_jmp: in STD_LOGIC;
        jump: in STD_LOGIC_VECTOR (7 downto 0);
        output: buffer integer range 0 to 255
    );
end entity;

architecture Behaviour of pcounter is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset='1' then
                output <= 0;
            elsif enable_jmp='1' then
                output <= to_integer(signed(jump));
            elsif enable='1' then
                output <= output+1;
            end if;
        end if;
    end process;

end architecture;