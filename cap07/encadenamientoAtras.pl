% Un interprete de encadenamiento hacía atrás para reglas if-then.

:-  op( 800, fx, if).
:-  op( 700, xfx, then).
:-  op( 300, xfy, or).
:-  op( 200, xfy, and).

is_true( P)  :-
   fact( P).

is_true( P)  :-
   if Cond then P,        % Una regla relevante,   
   is_true( Cond).        % cuya condición Cond es verdadera. 

is_true( P1 and P2)  :-
   is_true( P1),
   is_true( P2).

is_true( P1 or P2)  :-
   is_true( P1)
   ;
   is_true( P2).
