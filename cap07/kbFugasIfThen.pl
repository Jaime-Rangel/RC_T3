%%% base de conocimiento para fugas, en fomato de reglas if-then

%%% Conocimiento previo

if sala_humeda and cocina_seca
then fuga_en_bano.

if sala_humeda and bano_seco
then problema_en_cocina.

if ventana_cerrada or no_lluvia
then no_agua_del_exterior.

if problema_en_cocina and no_agua_del_exterior
then fuga_en_cocina.

%%% Evidencias

fact(sala_seca).        % Cambiar a sala\_seca para que falle la meta
fact(bano_seco).
fact(ventana_cerrada).    % Comentar para probar explicaciones porque

%%% Hechos que se pueden preguntar la usuario

askable(no_lluvia).
askable(ventana_cerrada).
