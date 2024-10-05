library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont16 is
    port (
        Clk: in STD_LOGIC;
        T: in STD_LOGIC;
        Q: out STD_LOGIC_VECTOR (15 downto 0);
        clear: in STD_LOGIC
    );
end entity cont16;

architecture Behaviour of cont16 is
signal output: STD_LOGIC_VECTOR (15 downto 0);
begin 
    process(Clk)
    begin
        if (rising_edge(Clk)) then
            if (Clear='1') then
                output <= "0000000000000000";
            elsif (T='1') then
                output <= output+1;
            else
                output <= output;
            end if;
        end if;
    end process;
    Q <= output;
end architecture Behaviour;