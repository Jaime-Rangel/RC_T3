:- dynamic already_asked/1.

% iis\_true(P,A): P es el caso con la explicación A.
% Versión interactiva con el usuario.

iis_true(P,A) :-
    explore(P,A,[]).

% explore(P,A,T): A es una explicación de porque P es verdadera, H
% es una cadena de reglas que liga P con las metas anteriores.

explore(P, P, _) :-
    fact(P).

explore(P1 and P2, A1 and A2, T) :-
    explore(P1, A1, T),
    explore(P2, A2, T).

explore(P1 or P2, A1 or A2, T) :-
    explore(P1, A1, T)
    ;
    explore(P2, A2, T).

explore(P, P <= ACond, T) :-
    if Cond then P,
    explore(Cond, ACond, [if Cond then P | T]).

explore(P,A,T) :-
    askable(P),
    \+ fact(P),
    \+ already_asked(P),
    ask_user(P, A, T).

% ask\_user(P,A,T): Pregunta al usuario si P es el caso,
% generando las explicaciones A y T.

ask_user(P, A, T) :-
    nl, write('Es cierto que: '), write(P),
    writeln(' Conteste si/no/porque:'),
    read(Resp),
    process_answer(Resp,P,A,T).

process_answer(si,P, P <= preguntado,_) :-
    asserta(fact(P)),
    asserta(already_asked(P)).

process_answer(no,P,_,_) :-
    asserta(already_asked(P)),
    fail.

process_answer(porque,P,A,T) :-
    display_rule_chain(T,0), nl,
    ask_user(P,A,T).

% display\_rule\_chain(R,N): Despliega las reglas R,
% identando a nivel N.

display_rule_chain([],_).

display_rule_chain([if Cond then P | Reglas], N) :-
    nl, tab(N), write('Para explorar si '),
    write(P), write(' es el caso, usando la regla '),
    nl, tab(N), write(if Cond then P),
    N1 is N + 2,
    display_rule_chain(Reglas,N1).
