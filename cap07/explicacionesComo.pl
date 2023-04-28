% is\_true(P,A) A es el árbol de prueba de la meta proposicional P

:- op(800, xfx, <=).

is_true(P,P) :-
    fact(P).

is_true(P, P <= CondA) :-
    if Cond then P,
    is_true(Cond,CondA).

is_true(P1 and P2, A1 and A2) :-
    is_true(P1,A1),
    is_true(P2,A2).

is_true(P1 or P2, A1 or A2) :-
    is_true(P1,A1)
    ;
    is_true(P2,A2).

% show\_tree(A): Imprime el árbol de derivación A.

show_tree(A) :-
    show_tree(A,0).

% show\_tree(A,N): Imprime el árbol de derivación A,
% al nivel de indentación N.

show_tree(A,N) :-
    var(A), tab(N), writeln('cualquier_cosa').

show_tree(A1 <= A2,N) :- !,
    tab(N), write(A1), writeln(' <='),
    show_tree(A2,N).

show_tree(A1 and A2,N) :- !,
    N1 is N + 2,
    show_tree(A1,N1), tab(N1), writeln('and'),
    show_tree(A2,N1).

show_tree(A1 or A2,N) :- !,
    N1 is N + 2,
    show_tree(A1,N1), tab(N1), writeln('or'),
    show_tree(A2,N1).

show_tree(A,N) :-
    tab(N),writeln(A).

