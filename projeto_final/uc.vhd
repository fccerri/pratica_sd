library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uc is
    port (
        op: in STD_LOGIC_VECTOR (7 downto 0)
    );
end entity;

architecture Behaviour of uc is

begin

    process(all)
    begin
        case op(7 downto 4) is
            when "0000" =>
            when "0001" =>
            when "0010" =>
            when "0011" =>
            when "0100" =>
            when "0101" =>
            when "0110" =>
            when "0111" =>
            when "1000" =>
            when "1001" =>
            when "1010" =>
            when "1011" =>
            when "1100" =>
            when "1101" =>
            when "1110" =>
            when others =>
        end case; 
    end process;

end architecture;