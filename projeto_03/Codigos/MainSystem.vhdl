library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity MainSystem is
    port(
        clk: in STD_LOGIC;
        reset: in STD_LOGIC := '0';
		enable: in STD_LOGIC := '1';
        input_letter: in STD_LOGIC_VECTOR(2 downto 0); 
        signal_out: out STD_LOGIC  
    );
end entity;

architecture Behaviour of MainSystem is
	signal start : STD_LOGIC := '0'; --sinal para indicar que o sistema pode emitir o morse(ativar em 1 ao resetar o sistema, desativar em 0 quando no estado do SHIFT o número de bits for alcançado
    signal shift_output: STD_LOGIC_VECTOR(3 downto 0); --sinal para saída do shift register
    signal enable_shifter: STD_LOGIC := '0'; -- sinal que habilita o shift register.
	signal reset_shifter: STD_LOGIC := '1'; -- sinal que reseta o shifter
    signal enable_counter05, enable_counter15, enable_counter_low: STD_LOGIC := '0'; -- sinal que habilita os contadores. Esses só devem estar ativos no estado dos contadores(ativar um por estado de contador), nos demais estados esses devem estar desativados.
    signal reset_counter05, reset_counter15, reset_counter_low: STD_LOGIC := '0'; -- sinal que reseta os contadores. Esses só devem estar desativados no estado dos contadores(desativar um por estado de contador), nos demais estados eles devem estar desligados
    signal rollover_counter05, rollover_counter15, rollover_counter_low: STD_LOGIC := '0'; -- sinal de rollover indicando que o contador terminou sua contagem
    signal current_bit: STD_LOGIC := '0'; -- sinal corresponde ao bit atual sendo lido pela saída do shift register
    signal input_vector: STD_LOGIC_VECTOR(3 downto 0); -- mapeamento dos bits pelas switches
    signal character_size: integer range 0 to 4 := 0;  --tamanho do vetor de caracteres da letra

begin
	-- Nesse processo estou lendo a entrada(input_letter) e armazenando em um registrador(input_vector) os bits correspondentes as letras
    process(input_letter)
    begin
        case input_letter is
            when "000" => 
					input_vector <= "0100"; -- A ".-", "."=0, "-"=1
					character_size <= 2; 
            when "001" =>
					input_vector <= "1000"; -- B 
					character_size <= 4;
            when "010" =>
					input_vector <= "1010"; -- C
					character_size <= 4;
            when "011" =>
					input_vector <= "1000"; -- D
					character_size <= 3;
            when "100" => 
					input_vector <= "0000"; -- E
					character_size <= 1;
            when "101" => 
					input_vector <= "0010"; -- F
					character_size <= 4;
            when "110" => 
					input_vector <= "1100"; -- G
					character_size <= 3;
            when "111" => 
            	input_vector <= "0000"; -- H
					character_size <= 4;
            when others => 
					input_vector <= "0000"; -- Don't care
					character_size <= 0;
        end case;
    end process;

    shift: entity work.shifter
        port map (
            clk => clk,
            reset => reset_shifter,
            enable => enable_shifter,
            input => input_vector,
            output => shift_output
        );

    counter05: entity work.contador
        generic map (
            n => 1,
            k => "1",
            c => 25000000
        )
        port map (
            clk => clk,
            reset => reset_counter05, 
            enable => enable_counter05,
            output => open,
            rollover => rollover_counter05
        );

    counter15: entity work.contador
        generic map (
            n => 1,
            k => "1",
            c => 75000000
        )
        port map (
            clk => clk,
            reset => reset_counter15, 
            enable => enable_counter15,
            output => open,
            rollover => rollover_counter15
        );

    counter_low: entity work.contador
        generic map (
            n => 1,
            k => "1",
            c => 5000000
        )
        port map (
            clk => clk,
            reset => reset_counter_low, 
            enable => enable_counter_low,
            output => open,
            rollover => rollover_counter_low
        );

    process(clk, reset)
        type state_type is (IDLE, COUNT_05, COUNT_15, COUNT_LOW, SHIFT); --defini��o dos estados, instru��o de alto nível para abstra��o, basicamente colocando nome nos estados ao inv�s de simplesmente chamar de 00, 01, 10, 11...
        variable state: state_type := IDLE; --criando a vari�vel estado e atribui�ndo valor inicial para IDLE
        variable bit_counter: integer range 0 to 4 := 0;--criando a vari�vel para contar os bits que o shift register leu
    begin
		--reset assincrono. Nesse estado a vari�vel start � setado para 1, estado para IDLE, 
        --apagar LED, resetar contadores, resetar contador de bits e desabilitar contadores
        if reset = '0' then
			start <= '0';
            state := IDLE;
            signal_out <= '0';
            enable_counter05 <= '0';
            enable_counter15 <= '0';
            enable_counter_low <= '0';
            enable_shifter <= '0';
            bit_counter := 0;
            reset_counter05 <= '1'; 
            reset_counter15 <= '1';
            reset_counter_low <= '1';
			reset_shifter <= '1';
		    -- durante as gransi��es de clock os estados podem ser transicionados
		elsif enable='0' then
			start <= '1';
			state := IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
					--Deixar todos os contadores desabilitados e resetados
					enable_counter05 <= '0';
                    enable_counter15 <= '0';
                    enable_counter_low <= '0';
                    reset_counter05 <= '1';
                    reset_counter15 <= '1';
                    reset_counter_low <= '1';
					--caso o sinal start estiver em 0 se manter no estado idle(state := IDLE;)
                    if start = '1' then
                        reset_shifter <= '0';
                        enable_shifter <= '1';
                        current_bit <= shift_output(3);
                        state := SHIFT;
                    elsif start='0' then
                        state := IDLE;
                    end if;
				when COUNT_05 =>
                    --Ligar LED, Habilitar contador para esse estado, desativar o reset e desabilitar o shifter
				    --quando o contador terminar de contar(rollover_counter05), desabiltiar o contador e mudar estado para COUNT_LOW
					signal_out <= '1';
                    enable_counter05 <= '1';
                    reset_counter05 <= '0';
                    enable_shifter <= '0';
                    if rollover_counter05='1' then 
						enable_counter05 <= '0';
                        reset_counter05 <= '1';
                        state := COUNT_LOW;
                    end if;
                when COUNT_15 =>
                    --Mesma coisa do COUNT_05 mas para o COUNT_15, mesma l�gica, sinais e contadores diferentes.
					signal_out <= '1';
                    enable_counter15 <= '1';
                    reset_counter15 <= '0';
                    enable_shifter <= '0';
                    if rollover_counter15='1' then 
                        enable_counter15 <= '0';
                        reset_counter15 <= '1';
						state := COUNT_LOW;
                    end if;
                when COUNT_LOW =>
                    --Quase a mesma coisa do COUNT_05 mas para o COUNT_LOW, mesma l�gica, sinais e contadores diferentes.
					--Diferen�a � que o LED ficar� apagado e o pr�ximo estado � o shift
					--Habilitar o shifter e ler o primeiro digito dele, assim como no current_bit
					signal_out <= '0';
					enable_counter_low <= '1';
                    reset_counter_low <= '0';
                    enable_shifter <= '0';
                    if rollover_counter_low='1' then 
						enable_shifter <= '1';
                        enable_counter_low <= '0';
                        reset_counter_low <= '1';
                        current_bit <= shift_output(3);
						state := SHIFT;
                    end if;
                when SHIFT =>
					--resetar os contadores, todos eles
					--desabilitar o shifter
					--Nesse estado o bit_counter deve ser atualizdo(bit_counter := bit_counter + 1;)
					--caso o bit_counter for igual character_size, todos os bits foram lidos
					--voltar para o estado IDLE. Dois sinais/vari�veis devem ser setados para 0
					--caso contr�rio a mudan�a de estado depender� do bit atual(current_bit) 
                    --se for zero vai para o estado COUNT_05, se não COUNT_15
					enable_counter05 <= '0';
					enable_counter15 <= '0';
                    enable_counter_low <= '0';
                    reset_counter05 <= '1';
                    reset_counter15 <= '1';
                    reset_counter_low <= '1';
                    enable_shifter <= '0';
                    if bit_counter=character_size then
						start <= '0';
                        bit_counter := 0;
                        reset_shifter <= '1';
                        state := IDLE;
                    else 
						bit_counter := bit_counter+1;
                    if current_bit='0' then
						state := COUNT_05;
                    else
                        state := COUNT_15;
                    end if;
                end if;
            end case;
        end if;
    end process;
end architecture Behaviour;


