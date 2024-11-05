library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uc is
    port (
        op: in STD_LOGIC_VECTOR (7 downto 0);
        clk, reset : in STD_LOGIC; --controle da uc
        pc : out STD_LOGIC_VECTOR(7 downto 0);
		read, write, mem_enable : out  STD_LOGIC; --controle da memoria
		input_enable, output_enable: out STD_LOGIC -- controle de entrada/saida
        -- fazer bagulho de atualizar o registrador
    );
end entity;

architecture behaviour of uc is

    component ula is
        port (
            op: in STD_LOGIC_VECTOR (7 downto 0);
            A: in STD_LOGIC_VECTOR (7 downto 0);
            B: in STD_ULOGIC_VECTOR (7 downto 0);
            R: out STD_LOGIC_VECTOR (7 downto 0);
            Zero: out STD_LOGIC := '0';
            Sinal: out STD_LOGIC := '0';
            Carry: out STD_LOGIC := '0';
            Overflow: out STD_LOGIC := '0'
        );
    end component;

    constant ADD   : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant SUB   : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ANDD  : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ORR   : STD_LOGIC_VECTOR (3 downto 0) := "0011";
    constant NOTT  : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant CMP   : STD_LOGIC_VECTOR (3 downto 0) := "0101";
    constant JMP   : STD_LOGIC_VECTOR (3 downto 0) := "0110";
    constant JEQ   : STD_LOGIC_VECTOR (3 downto 0) := "0111";
    constant JGR   : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant LOAD  : STD_LOGIC_VECTOR (3 downto 0) := "1001";
    constant STORE : STD_LOGIC_VECTOR (3 downto 0) := "1010";
    constant MOV   : STD_LOGIC_VECTOR (3 downto 0) := "1011";
    constant INN   : STD_LOGIC_VECTOR (3 downto 0) := "1100";
    constant OUTT  : STD_LOGIC_VECTOR (3 downto 0) := "1101";
    constant WAITT : STD_LOGIC_VECTOR (3 downto 0) := "1110";

begin

    alu: ula
    port map(
        op => op(7 downto 4),
        A => A,
        B => B,
        R => R,
        Zero => Zero,
        Sinal => Sinal, 
        Carry => Carry,
        Overflow => Overflow
    );

    process(clk, reset)

    signal Reg1, Reg2, R, IR, A, B: STD_LOGIC_VECTOR(7 downto 0); --sera substituido pelos regs
    signal Zero, Sinal, Carry, Overflow: STD_LOGIC;

    type state_type is (FETCH, DECODE, EXECUTE, IMEDIATO); 
        variable state: state_type := DECODE; --criando a variável estado e atribui­ndo valor inicial para DECODE
    
    begin
        if reset = '1' then
            pc <= (others => '0'); 
            read <= '0'; --??
            write <= '0'; --??
            input_enable <= '0';
            output_enable <= '0';
            state <= FETCH;
        end if;

        if rising_edge(clk) then
            case state is
                when FETCH =>
                    IR <= op;
                    pc <= std_logic_vector(unsigned(pc) + 1);
                    state <= DECODE;

                when DECODE =>
                    case op(3 downto 2) is --estabelece a variavel A da ula
                        when ("00") => 
                            A <= Reg1;
                        when ("01") => 
                            A <= Reg2;
                        when ("10") =>
                            A <= R;
                        when ("11") => 
                            state <= IMEDIATO;
                    end case;

                    case op(1 downto 0) is --estabelece a variavel B da ula
                        when ("00") => 
                            B <= Reg1;
                        when ("01") => 
                            B <= Reg2;
                        when ("10") =>
                            B <= R;
                        when ("11") => 
                            state <= IMEDIATO;
                    end case;

                    if (op(7 downto 4) = LOAD OR op(7 downto 4) = STORE OR --vai para o estado imediato 
                         op(7 downto 4) = JMP OR
                        op(7 downto 4) = JEQ OR op(7 downto 4) = JGR) then 
                        state <= IMEDIATO;
                    end if;


                when IMEDIATO =>
                    if (op(3 downto 2) = "11") then
                        A <= op;
                    elsif (op(3 downto 2) = "11") then
                        B <= op;
                    end if;

                    pc <= std_logic_vector(unsigned(pc) + 1);
                    state <= EXECUTE;

                when EXECUTE => 

                case op(7 downto 4) is
                    when ADD => 
                        --reg R recebe saida ula     

                    when "0001" => --sub
                        --reg R recebe saida ula
                    when "0010" => --and
                        --reg R recebe saida ula
                    when "0011" => --or
                    --reg R recebe saida ula
                    when "0100" => --not
                    --reg R recebe saida ula
                    when "0101" => --cmp
                    --habilitar escrever flags
                    when "0110" => --jmp
                        pc <= op;

                    when "0111" =>  --jeq 
                        if (Zero = '1') then
                            pc <= op;
                        end if;

                    when "1000" => --jgr
                    if (Zero = '0') then
                        pc <= op;
                    end if;

                    when "1001" => --load
                        mem_enable <= '1';  

                    when "1010" => --store
                    when "1011" => --mov
                    when "1100" => --in
                    when "1101" => --out
                    when "1110" => --wait
                    when others =>
                end case; 
            end case;
        end if;
    end process;

end architecture;