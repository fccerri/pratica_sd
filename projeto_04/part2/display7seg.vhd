library IEEE;
use IEEE.std_logic_1164.all;

entity display7seg is
    port(
        in_disp: in STD_LOGIC_VECTOR (3 downto 0);
        out_disp: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity display7seg;

architecture Behaviour of  display7seg is
begin
    process(in_disp)
    begin 
        case in_disp is
            when "0000" => out_disp <= "1000000"; --0
            when "0001" => out_disp <= "1111001"; --1
            when "0010" => out_disp <= "0100100"; --2
            when "0011" => out_disp <= "0110000"; --3
            when "0100" => out_disp <= "0011001"; --4
            when "0101" => out_disp <= "0010010"; --5
            when "0110" => out_disp <= "0000010"; --6 
            when "0111" => out_disp <= "1111000"; --7
            when "1000" => out_disp <= "0000000"; --8
            when "1001" => out_disp <= "0010000"; --9
            when "1010" => out_disp <= "0001000"; --A
            when "1011" => out_disp <= "0000011"; --b
            when "1100" => out_disp <= "1000110"; --c
            when "1101" => out_disp <= "0100001"; --d
            when "1110" => out_disp <= "0000110"; --E
            when "1111" => out_disp <= "0001110"; --F
            when others => out_disp <= "0000000"; --mostra 8, mas é só p precaução
        end case;
    end process;
end architecture Behaviour;
