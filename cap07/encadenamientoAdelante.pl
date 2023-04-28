% Un intérprete simple para el razonamiento hacia adelante

forward :-
    new_derived_fact(P),    % Se deriva un nuevo hecho.
    !,
    write('Nuevo hecho derivado: '), write(P), nl,
    assert(fact(P)),
    forward   % Buscar más hechos nuevos.
    ;
    write('No se derivaron más hechos.').   % Terminar, no más hechos derivados.

new_derived_fact(Concl) :-
    if Cond then Concl,   % Una regla
    \+ fact(Concl),       % cuya conclusión no es un hecho
    composed_fact(Cond).  % Su condición es verdadera?

composed_fact(Cond) :-
    fact(Cond).           % Un hecho simple

composed_fact(Cond1 and Cond2) :-
    composed_fact(Cond1),
    composed_fact(Cond2). % Ambos operandos verdaderos.

composed_fact(Cond1 or Cond2) :-
    composed_fact(Cond1)
    ;
    composed_fact(Cond2). % Al menos un operando verdadero.
