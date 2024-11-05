library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ula is
    port (
        OP: in STD_LOGIC_VECTOR (3 downto 0);
        A: in STD_LOGIC_VECTOR (7 downto 0);
        B: in STD_ULOGIC_VECTOR (7 downto 0);
        R: out STD_LOGIC_VECTOR (7 downto 0);
        Zero: out STD_LOGIC := '0';
        Sinal: out STD_LOGIC := '0';
        --Carry: out STD_LOGIC := '0';
        Overflow: out STD_LOGIC := '0'
    );
end entity;

architecture Behaviour of ula is
    
begin
    
    process(all)
    begin 
        case OP is
            when "0000" => 
                R <= STD_LOGIC_VECTOR(signed(A) + signed(B));
                if ((signed(A) > 0)and(signed(B) > 0)and(signed(R) < 0)) then 
                    Overflow <= '1';
                elsif ((signed(A) < 0)and(signed(B) < 0)and(signed(R) > 0)) then
                    Overflow <= '1';
                end if;
            when "0001" =>
                R <= STD_LOGIC_VECTOR(signed(A) - signed(B));
                if ((signed(A) > 0)and(signed(B) < 0)and(signed(R) < 0)) then
                    Overflow <= '1';
                elsif ((signed(A) < 0)and(signed(B) > 0)and(signed(R) > 0)) then 
                    Overflow <= '1';
                end if;
            when "0010" => R <= A and B;
            when "0011" => R <=  A or B;
            when "0100" => R <= not A;
            when others =>
        end case;
        if (unsigned(R) < 0) then
            Sinal <= '1';
        elsif (unsigned(R) = 0) then
            Zero <= '1';
        end if;
    end process;
    
end architecture Behaviour;