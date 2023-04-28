% Motor de inferencia para Red Bayesiana

% Una Red Bayesiana es representada usando:
%    padre( Padre, Hijo)
%    p( Nodo, EstadosPadre, Prob)
%      donde Prob es la probabilidad condicional de Nodo dados los
%      los valores de las variables en EstadosPadre, ej: 
%      p( alarma, [ ladron, not terremoto], 0.99)
%    p( Nodo, Prob)
%      probabilidad Prob de Nodo sin padres


% prob( Evento, Cond, P):
%   la probabilidad de Evento, dada Cond, es P;
%   Evento es una variable,su negación, o una lista
%   de eventos simples bajo conjunción

:-  op(  900, fy, not).

prob( [X | Xs], Cond, P)  :-  !,   % Prob de la conjunción
  prob( X, Cond, Px),
  prob( Xs, [X | Cond], PRest),
  P is Px * PRest.

prob( [], _, 1)  :-  !.            % Conjunción vacía

prob( X, Cond, 1)  :-
  miembro( X, Cond), !.             % Cond implica X

prob( X, Cond, 0)  :-
  miembro( not X, Cond), !.         % Cond implica X es falsa

prob( not X, Cond, P)  :-  !,      % Negación
  prob( X, Cond, P0),
  P is 1 - P0.

% Usa la regla de Bayes si Cond0 incluye un descendiente de X

prob( X, Cond0, P)  :-
  borrar( Y, Cond0, Cond),
  pred( X, Y), !,           % Y es un descendiente de X
  prob( X, Cond, Px),
  prob( Y, [X | Cond], PyDadoX),
  prob( Y, Cond, Py),              
  P is Px * PyDadoX / Py.         % Asumiendo Py > 0

% Casos donde Cond no involuchra a un descendiente

prob( X, _, P)  :-
  p( X, P), !.              	   % X una causa raíz - prob dada

prob( X, Cond, P)  :-  !,
  findall( (Condi,Pi), p(X,Condi,Pi), CPlist),  % Conds padres
  suma_probs( CPlist, Cond, P).

% suma\_probs( CondsProbs, Cond, SumaPond)
%   CondsProbs es una lista de conds y sus probs
%   SumaPond suma de probs de Conds dada0 Cond

suma_probs( [], _, 0).

suma_probs( [ (Cond1,P1) | CondsProbs], Cond, P)  :-
  prob( Cond1, Cond, PC1),
  suma_probs( CondsProbs, Cond, PResto),
  P is P1 * PC1 + PResto.

% pred(var1,var2). var1 es predecesora de var2 en la red.

pred( X, not Y)  :- !,        % Y negada
  pred( X, Y).

pred( X, Y)  :-
  padre( X, Y).

pred( X, Z)  :-
  padre( X, Y),
  pred( Y, Z).

% miembro(X,L). X es miembro de L.

miembro( X, [X | _]).

miembro( X, [_ | L])  :-
  miembro( X, L).

% borrar(X,L). Borra la primer ocurrencia de X en L, si es el caso.

borrar( X, [X | L], L).

borrar( X, [Y | L], [Y | L2])  :-
  borrar( X, L, L2).
