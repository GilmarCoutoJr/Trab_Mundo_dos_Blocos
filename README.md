# Trab_Mundo_dos_Blocos
Repositório para o trabalho 1 da disciplina de IA. 

Alunos: Luíz Eduardo [22251141] | Gabrielly Rodrigues [22152262] | Gilmar Couto Jr. [22152247]

# Projeto de Planejamento de Movimentos de Blocos

## Descrição

O problema consiste em um mundo formado por blocos que podem ser empilhados uns sobre os outros ou colocados diretamente sobre a mesa. Os blocos são de diferentes comprimentos (larguras), mas iguais em altura. A principal diferença visual entre eles é, portanto, o comprimento. O objetivo do sistema é mover os blocos de modo a transformar um estado inicial do mundo em um estado final desejado, respeitando restrições como não poder colocar blocos sobre outros blocos que já estão "ocupados" (ou seja, que já têm algo em cima).

### Funcionalidades

* **Verificação de Metas**: Verifica se todas as metas foram atingidas.
* **Seleção de Metas**: Permite a seleção de metas a serem atingidas.
* **Ações e Efeitos**: As ações podem adicionar ou remover blocos de posições e alterar o estado do mundo.
* **Planejamento de Ações**: Um plano de ações é gerado para mover blocos de acordo com as metas.
* **Execução de Ações**: As ações são executadas sequencialmente para alcançar o estado final desejado.

## Requisitos

* Prolog (o código foi desenvolvido e testado em SWI-Prolog)

## Como Usar

1. **Carregar o Código**: Carregue o arquivo de código no SWI-Prolog.

2. **Rodar o Planejamento**:

   * Para iniciar o planejamento, use o predicado `plan/3`, passando o estado inicial, o estado final e uma variável para o plano de ações:

     ```prolog
     plan(_, _, Plano).
     ```
   * O predicado irá gerar um plano e executá-lo, movendo os blocos do estado inicial para o estado final.

3. **Verificar se uma Meta foi Satisfeita**:

   * Para verificar se uma meta foi satisfeita, utilize o predicado `satisfied/2` passando o estado atual e as metas a serem verificadas:

     ```prolog
     satisfied(Estado, Metas).
     ```

4. **Mover Blocos**:

   * Para mover um bloco de uma posição para outra, utilize o predicado `move/4`, passando o bloco, a posição de origem, a posição de destino, o estado atual e a variável para o novo estado:

     ```prolog
     move(Bloco, De, Para, Estado, NovoEstado).
     ```

## Estrutura do Código

* **Predicados Principais**:

  * `satisfied/2`: Verifica se todas as metas foram atingidas.
  * `select_goal/2`: Seleciona uma meta a partir de uma lista de metas.
  * `achieves/2`: Verifica se uma ação alcança uma meta.
  * `preserves/2`: Verifica se uma ação preserva todas as metas, sem violar pré-condições.
  * `regress/3`: Regressa as metas após uma ação.
  * `can/2`: Verifica se uma ação pode ser realizada com base nas suas pré-condições.

* **Predicados de Estado**:

  * `livre/2`: Verifica se um bloco está livre.
  * `livre_destino/2`: Verifica se o destino de um bloco está livre.
  * `estado_inicial/1`: Define o estado inicial do mundo dos blocos.
  * `estado_final/1`: Define o estado final desejado.

* **Predicados de Ação**:

  * `move/4`: Define a ação de mover um bloco.
  * `retira_bloco/3`: Remove um bloco de sua posição.
  * `coloca_bloco/3`: Coloca um bloco em uma nova posição.

## Exemplo de Uso

Após carregar o código no SWI-Prolog, basta rodar o seguinte:

```prolog
?- plan(_, _, Plano).
```

Isso irá gerar um plano de movimentos de blocos que moverá os blocos do estado inicial para o estado final desejado.
