library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont_p4 is
    port (
        Clk: in STD_LOGIC;
        T: in STD_LOGIC;
        Q: out STD_LOGIC_VECTOR (1 downto 0);
        clear: in STD_LOGIC
    );
end entity cont_p4;

architecture Behaviour of cont_p4 is
signal seg: STD_LOGIC_VECTOR ( 25 downto 0);
signal output: STD_LOGIC_VECTOR (1 downto 0);
begin 
    process(Clk)
    begin
        if (rising_edge(Clk)) then
            if (Clear='1') then
                seg <= "00000000000000000000000000";
                output <= "00";
            elsif (T='1') then
                seg <= seg+1;
                if (seg = "10111110101111000010000000") then
                    if (output = "10") then
                        output <= "00";
                        seg <= "00000000000000000000000000";
                    else
                        output <= output+1;
                        seg <= "00000000000000000000000000";
                    end if;
                end if;
            else
                seg <= seg;
            end if;
        end if;
    end process;
    Q <= output;
end architecture Behaviour;