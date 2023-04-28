% Base de conocimientos para fuga en casa

% Conocimiento previo

fuga_en_bano :-
    sala_seca,
    cocina_seca.

problema_en_cocina :-
    sala_humeda,
    bano_seco.

no_agua_del_exterior :-
    ventana_cerrada
    ;
    no_lluvia.

fuga_en_cocina :-
    problema_en_cocina,
    no_agua_del_exterior.

% Evidencia

sala_humeda.
bano_seco.
ventana_cerrada.
