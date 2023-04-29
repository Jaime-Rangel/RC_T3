% Facts
norma_establecida(ley_general_de_salud, articulo(3, fraccion(xvii))).
norma_establecida(ley_general_de_salud, articulo(134, fraccion(xiv))).
norma_establecida(ley_general_de_salud, articulo(136, fraccion(ii))).
norma_establecida(ley_general_de_salud, articulo(137)).
norma_establecida(ley_general_de_salud, articulo(138)).
norma_establecida(ley_general_de_salud, articulo(142)).
norma_establecida(nom_017_ssa_2_2012, apartado('6.5')).
norma_establecida(nom_017_ssa_2_2012, apartado('6.5.1')).
norma_establecida(nom_017_ssa_2_2012, apartado('6.5.2')).
norma_establecida(reglamento_sanitario_internacional, articulo(2)).
norma_establecida(reglamento_sanitario_internacional, articulo(3)).
norma_establecida(reglamento_sanitario_internacional, articulo(6)).
norma_establecida(reglamento_sanitario_internacional, articulo(19)).
norma_establecida(reglamento_sanitario_internacional, articulo(23)).
norma_establecida(reglamento_sanitario_internacional, articulo(24)).
norma_establecida(reglamento_sanitario_internacional, articulo(30)).
norma_establecida(reglamento_sanitario_internacional, articulo(31)).
norma_establecida(reglamento_sanitario_internacional, articulo(43)).

%Objectives for Covid suspects
objetivo_general(objetivos_especificos,toma_muestra,sospechoso_COVID).
objetivo_general(objetivos_especificos,manejo_muestra,sospechoso_COVID).
objetivo_general(objetivos_especificos,envio_muestra,sospechoso_COVID).
%Objectives for covid behaviour
objetivo_general(objetivos_especificos,monitoreo,comportamiento_COVID).
objetivo_general(objetivos_especificos,alertamiento,comportamiento_COVID).
objetivo_general(objetivos_especificos,difusion,comportamiento_COVID).

accion_vigilancia(atencion).
accion_vigilancia(prevencion).
accion_vigilancia(control).

tipo_caso_covid(importado).
tipo_caso_covid(autoctono).

enfermedad(respiratoria,aguda).
enfermedad(respiratoria,leve).
enfermedad(respiratoria,grave).

pais_transmision(viaje_estancia,[china,hong_kong,corea_del_sur,japon,italia,iran,singapur]).
% pais_transmision(viaje_estancia_hong_kong).
% pais_transmision(viaje_estancia_corea_del_sur).
% pais_transmision(viaje_estancia_japon).
% pais_transmision(viaje_estancia_italia).
% pais_transmision(viaje_estancia_iran).
% pais_transmision(viaje_estancia_singapur).

contacto(caso_confirmado_covid,[importado,autoctono]).
contacto(caso_bajo_investigacion_covid,[importado,autoctono]).

objetivo_vigilancia_covid(prevenir_propagacion).

caso_sospechoso(X,Y,Z,W):-
    contacto(X,Y); pais_transmision(Z,W).

%definicion_operacional
%--------------------------------Page 11---------------------------------

%First Part
% objetivos_especificos(toma_muestra, sospechoso_COVID).
% objetivos_especificos(manejo_muestra, sospechoso_COVID).
% objetivos_especificos(envio_muestra, sospechoso_COVID).
%Second Part
% objetivos_especificos(monitoreo, sospechoso).
% objetivos_especificos(alertamiento, sospechoso).
% objetivos_especificos(difusion, sospechoso).

% Rules
norma_sustentada(Texto, Norma) :- norma_establecida(Norma, _), sub_string(Texto, _, _, _, Norma).

incumplimiento_descrito(Texto) :- sub_string(Texto, _, _, _, 'incumplimiento de las acciones de vigilancia epidemiológica descritas').

motivo_de_reporte(Texto, Secretaria, Competencia) :- incumplimiento_descrito(Texto), sub_string(Texto, _, _, _, 'persistencia'), Secretaria = 'Secretaría de Salud', Competencia = 'instancia jurídica de su competencia'.