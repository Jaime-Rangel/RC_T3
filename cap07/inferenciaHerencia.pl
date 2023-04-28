% Interprete Redes Semánticas

fact(Hecho) :-
    Hecho,!.

fact(Hecho) :-
    Hecho =.. [Rel,Arg1,Arg2],
    isa(Arg1,SuperClaseArg1),
    SuperHecho =.. [Rel,SuperClaseArg1,Arg2],
    fact(SuperHecho).

    
