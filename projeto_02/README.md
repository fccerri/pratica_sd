# Prática em Sistemas em Digitais - Atividade 2

## Resumo:
A atividade da semana (semanas 3 e 4) envolveu a aplicação de contadores com diferentes aplicações, todos as partes foram feitas utilizando em VHDL.
O projeto foi feito com base nos ![exercícios](lab4.pdf)
## Parte 1
O primeiro exercício realizado foi a construção de um contador síncrono de 4 bits a partir de flip flops do tipo T, rodamos uma simulação no model sim e depois representamos os bits em uma FPGA a partir de dois displays de 7 segmentos.

### Simulação 
![Part1_simulacao](Part1_simulacao.png)

### RTL VIEWER
Circuito Completo:
![Part1_RTL1](Part1_RTL1.png)

Contador:
![Part1_RTL2](Part1_RTL2.png)

T Flip Flop:
![PArt1_RTL3](PArt1_RTL3.png)


## Parte 2
No segundo exercício fizemos, de maneira similar a parte 1, um contador síncrono de 16 bits, no entanto no vhdl nós utilizamos um vetor para incrementar os bits. Fizemos então a implementação na FPGA através do Quartus.

### RTL VIEWER
Circuito Completo:
![PArt2_RTL1](PArt2_RTL1.png)

Contador:
![Part2_RTL2](Part2_RTL2.png)


## Parte 3
O exercício 4 por sua vez era baseado na exibição de uma palavra no display de 7 segmentos que  ficava rotacionando estaticamente da esquerda para direita, para tal, utilizamos do mesmo princípio do exercício 3, em que, o contador rápido conta até 50.000.000 para converter o ciclo de clock de 50 MHz em 1Hz, a única diferença foi no contador lento, já que o configuramos para contar apenas até 3 de forma que cada número foi relacionado a posição de cada letra, de forma que gerasse a rotação exigida.
parte 3 por sua vez, fizemos a implementação de um contador com clock integrado à FPGA, para isso, como o clock padrão da FPGA utilizada é de 50 MHZ, tivemos que utilizar um contador rápido que faz a contagem até 50.000.000 para então habilitar um ciclo de clock do contador lento a ser exibido na placa.

## Parte 4
O exercício 4 por sua vez era baseado na exibição de uma palavra no display de 7 segmentos que  ficava rotacionando estaticamente da esquerda para direita, para tal, utilizamos do mesmo princípio do exercício 3, em que, o contador rápido conta até 50.000.000 para converter o ciclo de clock de 50 MHz em 1Hz, a única diferença foi no contador lento, já que o configuramos para contar apenas até 3 de forma que cada número foi relacionado a posição de cada letra, de forma que gerasse a rotação exigida.

## Parte 5
A implementação da parte 5 foi muito semelhante a parte 4, no entanto, a palavra exibida nos display foi implementada de forma que rotaciona pelos displays juntamente as letras. Assim, a diferença está no contador lento, que possui 4 bits e cada número engloba mais possibilidades de representação no display, de modo que todas as casas de 7 segmentos exibem em algum momento as letras.
