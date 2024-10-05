# Prática em Sistemas em Digitais - Atividade 1

## Resumo:
A atividade da semana (semanas 2 e 3) envolveu a aplicação de diferentes tipos de flip-flops para guardar valores lógicos em uma memória, utilizando como ferramentas os esquemáticos do Quartus e programação em VHDL.

## Parte 1
Implementação de um RS-Lach, nesse caso já nos foi dado o código em VHDL e nós o compilamos no Quartus e também testamos seu funcionamento em FPGA e no simulador ModelSim.

## Parte 2
Implementação de um D-Latch, nesse caso nós construímos o circuito utilizando os esquemáticos do Quartus e exportamos o arquivo VDHL, testamos na FPGA e no ModelSim.

## Parte 3
Implementação de um master-slave D flip-flop, assim como na parte 2, criamos primeiro o circuito utilizando os esquemáticos do Quartus e depois exportamos o arquivo VHDL, testamos na FPGA e no ModelSim.

## Parte 4
Implementação de três circuitos: um D-Latch, um positive-edge triggered D flip-flop e um negative-edge triggered D flip-flop, todos compartilhando os mesmos 2 inputs (D e Clk), nessa parte fizemos primeiro o código em VHDL e depois simulamos no ModelSim.

## Parte 5
Implementação de um somador de palavras de 8 bits com uso de flip-flops, utilizamos 1 D-Latch's para cada bit de cada número (totalizando 16bits) de tal forma que fosse possível utilizar os mesmo switches como inputs para ambos, o circuito sequencial utiliza de 2 clocks idependentes responsávies por armazenar os números idependentemente, para isso utilizamos apenas os esquemáticos do Quartus e testamos em FPGA.
