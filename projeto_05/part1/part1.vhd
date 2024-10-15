library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part1 is
    port(
        clk: in STD_LOGIC; -- clock
        w: in STD_LOGIC;   -- entrada
        reset: in STD_LOGIC; -- reset
        z: OUT STD_LOGIC; -- saída
        led : out STD_LOGIC_VECTOR (8 downto 0) -- para mostrar em que estado estou
    );
end entity;

architecture Behaviour of part1 is

    component ff is
        port(
            clk: in STD_LOGIC;
            data: in STD_LOGIC;
            q: out STD_LOGIC
        );
    end component;

	 signal dx: STD_LOGIC_VECTOR (8 downto 0); -- para mostrar em que estado eu estou
    signal dz: STD_LOGIC; -- led 
    type state_type is (A, B, C, D, E, F, G, H, I); -- nomes dos estados
    signal state: state_type := A; -- inicializa no estado A

begin 

	 ffz: ff port map(clk => clk, data => dz, q => z);
    ff0: ff port map(clk => clk, data => dx(0), q => led(0));
    ff1: ff port map(clk => clk, data => dx(1), q => led(1));
    ff2: ff port map(clk => clk, data => dx(2), q => led(2));
    ff3: ff port map(clk => clk, data => dx(3), q => led(3));
    ff4: ff port map(clk => clk, data => dx(4), q => led(4));
    ff5: ff port map(clk => clk, data => dx(5), q => led(5));
    ff6: ff port map(clk => clk, data => dx(6), q => led(6));
    ff7: ff port map(clk => clk, data => dx(7), q => led(7));
    ff8: ff port map(clk => clk, data => dx(8), q => led(8));

    process(clk)
    begin 
        if rising_edge(clk) then
			if reset = '0' then
				state <= A;
				dz <= '0';
            dx <= "000000000";
			else 
				case state is
                when A =>
                    dz <= '0';
                    dx <= "000000000";
                    if w = '1' then
                        state <= B;
                    elsif w = '0' then
                        state <= F;
                    end if;
                when B =>
                    dz <= '0';
                    dx <= "000000011";
                    if w = '1' then
                        state <= C;
                    elsif w = '0' then 
                        state <= F;
                    end if;
                when C =>
                    dz <= '0';
                    dx <= "000000101";
                    if w = '1' then
                        state <= D;
                    elsif w = '0' then 
                        state <= F;
                    end if;
                when D =>
                    dz <= '0';
                    dx <= "000001001";
                    if w = '1' then
                        state <= E;
                    elsif w = '0' then 
                        state <= F;
                    end if;
                when E =>
                    dz <= '1';
                    dx <= "000010001";
                    if w = '1' then
                        state <= E;
                    elsif w = '0' then 
                        state <= F;
                    end if;
                when F =>
                    dz <= '0';
                    dx <= "000100001";
                    if w = '1' then
                        state <= B;
                    elsif w = '0' then  
                        state <= G;
                    end if;
                when G =>
                    dz <= '0';
                    dx <= "001000001";
                    if w = '1' then
                        state <= B;
                    elsif w = '0' then 
                        state <= H;
                    end if;
                when H =>
                    dz <= '0';
                    dx <= "010000001";
                    if w = '1' then
                        state <= B;
                    elsif w = '0' then  
                        state <= I;
                    end if;
                when I =>
                    dz <= '1';
                    dx <= "100000001";
                    if w = '1' then
                        state <= B;
                    elsif w = '0' then
								state <= I;
                    end if;
            end case;
			end if;
       end if;
    end process;
end architecture;
