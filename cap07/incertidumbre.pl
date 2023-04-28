% Interprete basado en reglas con incertidumbre

% cert(P,C): C es el grado de certeza de la proposición P

cert(P,C) :-
    given(P,C).

cert(P1 and P2, C) :-
    cert(P1,C1),
    cert(P2,C2),
    min(C1,C2,C).

cert(P1 or P2, C) :-
    cert(P1,C1),
    cert(P2,C2),
    max(C1,C2,C).

cert(P, C) :-
    if Cond then P:C1,
    cert(Cond,C2),
    C is C1 * C2.

cert(P, C) :-
    if Cond then P,
    cert(Cond,C1),
    C is C1.

% max y min

max(X,Y,X) :- X>=Y,!.
max(_,Y,Y).

min(X,Y,X) :- X=<Y,!.
min(_,Y,Y).
