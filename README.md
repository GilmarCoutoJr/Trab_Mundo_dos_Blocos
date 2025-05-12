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

## Predicados

### Predicados Principais

* **plan(EstadoInicial, EstadoFinal, Plano)**
  Gera um plano de ações para mover os blocos do estado inicial para o estado final.

  **Como usar**:
  Para executar o plano, basta rodar a consulta:
  `?- plan(estado_inicial, estado_final, Plano).`

* **executar\_plano(Plano, EstadoAtual, EstadoFinal)**
  Executa o plano gerado, movendo os blocos conforme as ações descritas.

### Predicados de Estado

* **estado\_inicial(Estado)**
  Define o estado inicial do mundo dos blocos, onde os blocos estão posicionados.

* **estado\_final(Estado)**
  Define o estado final desejado, onde os blocos devem ser posicionados.

* **livre(Bloco, Estado)**
  Verifica se o bloco está livre, ou seja, não há outro bloco sobre ele.

* **livre\_destino(Posicao, Estado)**
  Verifica se a posição de destino está livre, ou seja, não há outro bloco naquela posição.

### Predicados de Ação

* **move(Bloco, De, Para, Estado, NovoEstado)**
  Realiza a movimentação de um bloco de uma posição para outra, atualizando o estado.

* **adds(Action, Effects)**
  Define os efeitos da ação, ou seja, como o estado muda após a execução da ação.

* **delete\_all(Goals, Effects, Result)**
  Remove todos os itens das metas que estão presentes nos efeitos.

* **regress(Goals, Action, RegressedGoals)**
  Registra as metas após a execução de uma ação, lidando com as variáveis não instanciadas.

* **addnew(Preconditions, RemainingGoals, RegressedGoals)**
  Adiciona novas metas ao plano, verificando se são possíveis.

* **impossible(Goal, Goals)**
  Verifica se uma meta é impossível de ser alcançada.

* **preconditions(Action, Preconditions)**
  Define as pré-condições necessárias para que a ação seja realizada.

### Outros Predicados de Utilidade

* **retira\_bloco(Bloco, Posicao, Estado, NovoEstado)**
  Remove um bloco de sua posição no estado.

* **coloca\_bloco(Bloco, Posicao, Estado, NovoEstado)**
  Coloca um bloco em uma nova posição no estado.

## Como Usar o Simulador

1. **Carregar o código no SWI-Prolog**:
   Carregue o arquivo que contém o código no seu ambiente SWI-Prolog.

2. **Executar a consulta**:
   Para gerar um plano de ações para mover os blocos, execute a consulta abaixo no prompt do SWI-Prolog:

   ```prolog
   ?- plan(estado_inicial, estado_final, Plano).
   ```

   O Prolog gerará um plano de ações baseado nas condições de pré-condições e efeitos das ações. O plano será uma lista de ações que indicam como mover os blocos do estado inicial para o final.

3. **Verificar a execução do plano**:
   Após a execução do plano, o Prolog mostrará as etapas de movimentação dos blocos, incluindo os detalhes de qual bloco foi movido, de onde e para onde.

4. **Alterar o estado inicial ou final**:
   Caso queira testar diferentes configurações, basta modificar os predicados `estado_inicial` ou `estado_final` com novos valores.

---

### Exemplo de Uso

Considere o estado inicial e final definidos abaixo:

* **Estado Inicial**:

  * Bloco `c` em `[0, 2]`
  * Bloco `a` em `[3, 4]`
  * Bloco `b` em `[5, 6]`
  * Bloco `d` em `[3, 6]`

* **Estado Final**:

  * Bloco `a` em `[0, 1]`
  * Bloco `c` em `[0, 2]`
  * Bloco `d` em `[2, 5]`
  * Bloco `b` em `[5, 6]`

Após rodar o predicado `plan/3`, o Prolog retornará um plano com as ações necessárias para alcançar o estado final.

