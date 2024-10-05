library IEEE;
use IEEE.std_logic_1164.all;

--esse display eh para placa DE0-CV (dE0)
entity display_p4 is
    port(
        in_d0: in STD_LOGIC_VECTOR (1 downto 0);
        in_d1: in STD_LOGIC_VECTOR (1 downto 0);
        in_d2: in STD_LOGIC_VECTOR (1 downto 0);
        out_d0: out STD_LOGIC_VECTOR (6 downto 0);
        out_d1: out STD_LOGIC_VECTOR (6 downto 0);
        out_d2: out STD_LOGIC_VECTOR (6 downto 0)
    );
end entity display_p4;

architecture Behaviour of display_p4 is
begin
    process(in_d0)
    begin
        case in_d0 is
            when "00" => out_d0 <= "0000001";--0
            when "01" => out_d0 <= "1000010";--d
            when "10" => out_d0 <= "0110000";--E
            when others => out_d0 <= "0000000";
        end case;
    end process;
    process(in_d1)
    begin
        case in_d1 is
            when "00" => out_d1 <= "0110000";--E
            when "01" => out_d1 <= "0000001";--0
            when "10" => out_d1 <= "1000010";--d
            when others => out_d1 <= "0000000";
        end case;
    end process;
    process(in_d2)
    begin
        case in_d2 is
            when "00" => out_d2 <= "1000010";--d
            when "01" => out_d2 <= "0110000";--E
            when "10" => out_d2 <= "0000001";--0
            when others => out_d2 <= "0000000";
        end case;
    end process;
end architecture Behaviour;