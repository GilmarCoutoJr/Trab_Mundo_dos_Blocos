
% Regressa as metas após uma ação, lidando com variáveis não instanciadas
regress(Goals, Action, RegressedGoals) :-
    adds(Action, Effects),
    delete_all(Goals, Effects, RemainingGoals),
    can(Action, Preconditions),  % Verifica pré-condições da ação
    addnew(Preconditions, RemainingGoals, RegressedGoals),
    write('Regressed goals: '), write(RegressedGoals), nl.

% Predicado para verificar se uma meta já está satisfeita
satisfied_goal(livre(Bloco)) :-
    nonvar(Bloco),  % Garante que Bloco já foi instanciado
    estado_inicial(Estado),
    livre(Bloco, Estado).

satisfied_goal(livre_destino(Posicao)) :-
    nonvar(Posicao),
    estado_inicial(Estado),
    livre_destino(Posicao, Estado).

% Verifica se uma ação pode ser realizada, usando pré-condições
can(move(Bloco, _, Para), Preconditions) :-
    preconditions(move(Bloco, _, Para), Preconditions),
    forall(member(Precondition, Preconditions), satisfied_goal(Precondition)),
    format('Action move(~w, _, ~w) can be done with preconditions ~w~n', [Bloco, Para, Preconditions]).

% Predicado 'adds' que define os efeitos das ações
adds(move(Bloco, _, Para), [bloco(Bloco, Para)]).

% Remove todos os itens de Goals que estão em Effects
delete_all([], _, []).
delete_all([G|Goals], Effects, Result) :-
    member(G, Effects),
    delete_all(Goals, Effects, Result).
delete_all([G|Goals], Effects, [G|Result]) :-
    delete_all(Goals, Effects, Result).

% Adiciona novas metas ao plano
addnew([], L, L).
addnew([Goal | _], Goals, _) :-
    impossible(Goal, Goals),
    write('Impossible goal: '), write(Goal), nl,
    !, fail.
addnew([X | L1], L2, L3) :-
    member(X, L2),
    !, addnew(L1, L2, L3).
addnew([X | L1], L2, [X | L3]) :-
    addnew(L1, L2, L3).

% Predicado auxiliar para verificar impossibilidades
impossible(_, _) :- false.

% Predicado 'preconditions' que define as pré-condições para as ações
preconditions(move(Bloco, _, Para), [livre(Bloco), livre_destino(Para)]).

% Verifica se o bloco está livre (não há nada em cima dele)
livre(Bloco, Estado) :-
    \+ (member(bloco(_, _, Bloco), Estado)),
    write('Block '), write(Bloco), write(' is free'), nl, !.

% Verifica se o destino está livre (não há outro bloco ocupando a posição)
livre_destino(Posicao, Estado) :-
    \+ member(bloco(_, Posicao), Estado),
    write('Position '), write(Posicao), write(' is free'), nl, !.


% Estado inicial do Mundo dos Blocos
estado_inicial([
    bloco(c, [0, 2]),    
    bloco(a, [3, 4]),    
    bloco(b, [5, 6]),    
    bloco(d, [3, 6])     
]).

% Estado final desejado
estado_final([
    bloco(c, [0, 2]),    
    bloco(a, [0, 1]),    
    bloco(b, [5, 6]),    
    bloco(d, [2, 5])     
]).

% Movimento dos blocos, respeitando restrições de estabilidade
move(Bloco, De, Para, Estado, NovoEstado) :-
    livre(Bloco, Estado),
    livre_destino(Para, Estado),
    \+ member(bloco(Bloco, Para), Estado),
    retira_bloco(Bloco, De, Estado, TempEstado),
    coloca_bloco(Bloco, Para, TempEstado, NovoEstado),
    write('Moved block '), write(Bloco), write(' from '), write(De), write(' to '), write(Para), nl.

% Atualização do estado ao remover um bloco de sua posição
retira_bloco(Bloco, Posicao, [bloco(Bloco, Posicao) | Resto], Resto) :-
    write('Retirando bloco '), write(Bloco), write(' da posição '), write(Posicao), nl.
retira_bloco(Bloco, Posicao, [OutroBloco | Resto], [OutroBloco | NovoResto]) :-
    retira_bloco(Bloco, Posicao, Resto, NovoResto).

% Coloca um bloco em uma nova posição e atualiza o estado
coloca_bloco(Bloco, Posicao, Estado, [bloco(Bloco, Posicao) | Estado]) :-
    write('Colocando bloco '), write(Bloco), write(' na posição '), write(Posicao), nl.

% Gera um plano de ações para mover os blocos do estado inicial para o final
plan(_, _, Plano) :-
    estado_inicial(EstadoInicial), % Expande o estado inicial
    estado_final(EstadoFinal),     % Expande o estado final
    regress(EstadoFinal, _, Plano),
    executar_plano(Plano, EstadoInicial, EstadoFinal),
    write('Planning complete'), nl.

% Executa o plano gerado
executar_plano([], Estado, Estado) :-
    write('Plan execution complete'), nl.
executar_plano([move(Bloco, De, Para) | Restante], EstadoAtual, EstadoFinal) :-
    move(Bloco, De, Para, EstadoAtual, NovoEstado),
    executar_plano(Restante, NovoEstado, EstadoFinal).

% Para executar utilize a seguinte consulta: ?- plan(estado_inicial, estado_final, Plano).

% Caso queira verificar outras situações, realize alterações no "estado_inicial" e no "estado_final".
