library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity UC is
	port(
		opcode : in STD_LOGIC_VECTOR(3 downto 0); --instrucao
		clk, reset : in STD_LOGIC; --controle da uc
		read, write, mem_enable : out  STD_LOGIC; --controle da memoria
		input_enable, output_enable: out STD_LOGIC; -- controle de entrada/saida
		ula_opcode : out STD_LOGIC_VECTOR(1 downto 0); --instrucao pra ula
		ula_enable : out STD_LOGIC;
		pc_enable, ir_enable : out STD_LOGIC --controla o pc e registrador de inrucoes

		
		);
end UC;

architecture Behaviour of UC is
begin
	process(clk, reset)
	--type opcode_type is (ADD, SUB, AND_OP, OR_OP, NOT_OP,
		--CMP, JMP, JEQ, JGR, LOAD, STORE, MOV, IN_OP , OUT_OP, WAIT_OP);
    begin
		if reset = '1' then
            -- Sinais de controle são resetados
            ula_opcode <= "00";
			ula_enable <= '0';
            read <= '0';
            write <= '0';
            mem_enable <= '0';
            input_enable <= '0';
            output_enable <= '0';
            pc_enable <= '0';
            ir_enable <= '0';

		elsif (rising_edge(clk)) then 
			if (reset = '1') then
				--reset tudo
			else
				case (opcode) is 
					when ("00") => 
					ula_opcode <= "00"; --muda add signal
					ula_enable <= '1';

					mem_enable <= '0';
					--read <= '0';
					--write <= '0';

					pc_enable <= '0';
					ir_enable <= '0';

					input_enable <= '0';
					output_enable <= '0';

				end case;
					

				
			end if;
		end if;
	end process;
end architecture Behaviour;

