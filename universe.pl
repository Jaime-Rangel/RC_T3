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

presenta_enfermedad(enfermedad_respiratoria,[aguda,leve,grave]).

pais_transmision(viaje_estancia,[china,hong_kong,corea_del_sur,japon,italia,iran,singapur]).

contacto(caso,[confirmado,bajo_investigacion],[importado,autoctono]).
% contacto(caso_bajo_investigacion_covid,[importado,autoctono]).

objetivo_vigilancia_covid(prevenir_propagacion).

caso_sospechoso(E1,E2,C1,C2,C3,P1,P2):-
    presenta_enfermedad(E1,E2),contacto(C1,C2,C3);pais_transmision(P1,P2).

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