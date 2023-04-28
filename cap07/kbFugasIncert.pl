%%% base de conocimiento para fugas, en fomato de reglas if-then

%%% Conocimiento previo con certidumbre

if sala_humeda and cocina_seca
then fuga_en_bano.

if sala_humeda and bano_seco
then problema_en_cocina:0.9.

if ventana_cerrada or no_lluvia
then no_agua_del_exterior.

if problema_en_cocina and no_agua_del_exterior
then fuga_en_cocina.

% Evidencia con certidumbre

given(sala_humeda, 1).     % verdadero
given(bano_seco, 1).
given(cocina_seca, 0).     % falso
given(no_lluvia, 0.8).     % muy probable
given(ventana_cerrada, 0).
