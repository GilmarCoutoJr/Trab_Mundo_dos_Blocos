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

Este sistema implementa um planejador baseado em regressão no domínio do mundo dos blocos. A seguir estão os passos principais para utilizar os predicados:

### 1. Consultar o Arquivo

Carregue o arquivo no interpretador Prolog:

```prolog
?- [arquivo].  % Substitua 'arquivo' pelo nome do seu arquivo .pl
```

### 2. Verificar se as metas estão satisfeitas

Você pode verificar se um conjunto de metas já está satisfeito no estado atual:

```prolog
?- estado_inicial(S), estado_final(G), satisfied(S, G).
```

### 3. Selecionar uma Meta

Para inspecionar qual meta será escolhida:

```prolog
?- estado_final(Goals), select_goal(Goals, Goal).
```

### 4. Verificar Ações

Para saber se uma ação atinge uma meta:

```prolog
?- achieves(move(a, 4, 1), bloco(a, 1)).
```

### 5. Regressão de Metas

Para aplicar a regressão de metas em uma ação:

```prolog
?- estado_final(Goals), regress(Goals, move(a, 4, 1), NewGoals).
```

### 6. Planejar Automaticamente

Para gerar e executar um plano do estado inicial ao estado final:

```prolog
?- plan(_, _, Plano).
```

O plano será exibido e executado passo a passo, com saídas descritivas indicando os movimentos realizados.

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

  * `select_goal/2`: Seleciona uma meta da lista de metas.
  * `achieves/2`: Verifica se uma ação alcança uma determinada meta.
  * `preserves/2`: Verifica se uma ação preserva as metas (não as viola).
  * `regress/3`: Regride uma meta a partir de uma ação, gerando novas metas a serem satisfeitas.
  * `remove_satisfied/2`: Remove metas da lista que já estão satisfeitas.
  * `can/2`: Verifica se uma ação pode ser realizada com base nas pré-condições.
  * `plan/3`: Gera um plano de ações para atingir as metas a partir do estado inicial.
  * `executar_plano/3`: Executa o plano de ações gerado, modificando o estado até alcançar o estado final.

* **Predicados de Estado**:

  * `estado_inicial/1`: Define o estado inicial do mundo.
  * `estado_final/1`: Define o estado desejado (meta) do mundo.
  * `livre/2`: Verifica se um bloco está livre (nenhum bloco em cima dele).
  * `livre_destino/2`: Verifica se uma posição de destino está livre.
  * `satisfied_goal/1`: Verifica se uma meta já está satisfeita no estado atual.
  * `delete_all/3`: Remove da lista de metas aquelas que já foram satisfeitas por uma ação.

* **Predicados de Ação**:

  * `move/5`: Define a ação de mover um bloco.
  * `retira_bloco/4`: Remove um bloco de sua posição.
  * `coloca_bloco/4`: Coloca um bloco em uma nova posição.
  * `adds/2`: Define os efeitos positivos (adições) de uma ação.
  * `deletes/2`: Define os efeitos negativos (remoções) de uma ação.
  * `preconditions/2`: Define as pré-condições para que uma ação possa ser realizada.
  * `can/2`: Verifica se todas as pré-condições de uma ação são satisfeitas no estado atual.

## Exemplo de Uso

Após carregar o código no SWI-Prolog, basta rodar o seguinte:

```prolog
?- plan(_, _, Plano).
```

Isso irá gerar um plano de movimentos de blocos que moverá os blocos do estado inicial para o estado final desejado.
