%--------------------------------------------------Facts
%Objectives for Covid suspects
objetivos_especificos(toma_muestra,sospechoso_COVID).
objetivos_especificos(manejo_muestra,sospechoso_COVID).
objetivos_especificos(envio_muestra,sospechoso_COVID).

%Objectives for covid behaviour
objetivos_especificos(monitoreo,comportamiento_COVID).
objetivos_especificos(alertamiento,comportamiento_COVID).
objetivos_especificos(difusion,comportamiento_COVID).

%Countries where covid is a warning
pais_transmision_covid(viaje_estancia,[china,hong_kong,corea_del_sur,japon,italia,iran,singapur]).

%What are the sintoms of covid
enfermedad_covid(enfermedad,respiratoria,[aguda,leve,grave]).
sintomas_covid(sintoma,respiratorio).
sintomas_covid(sintoma,ninguno).

contacto_covid(caso_covid,[confirmado,bajo_investigacion],[importado,autoctono]).

diagnostico(covid_confirmado,inDre).
objetivo_vigilancia_covid(prevenir_propagacion).

personal_medico(medico,de_primer_contacto).
personal_medico(personal_epidemiologia,coordinacion_jurisdiccion_sanitaria).

unidad_salud(cubiculo,aislado,ventilado,puerta_cerrada).
unidad_medica(publica).
unidad_medica(privada).
atencion_medica(primer_nivel).

%Coordination jurisdiccion sanitaria
estudio_epidemiologico(llenado_del_estudio).
institucion_epidemiologica(toma_de_muestra).

usar(mascarilla_quirurgica_desechable,tolera).
usar(papel_higienico,no_tolera).

%Cuadro 1 Tarjeta Roja
usar(guantes,tarjeta_roja).
usar(mascarilla_proteccion_facial,tarjeta_roja).
usar(bata_impermeable,tarjeta_roja).
usar(contenedor_rigido,tarjeta_roja).
usar(agua,tarjeta_roja).
usar(jabon,tarjeta_roja).
usar(alcohol_gel_70_porciento,tarjeta_roja).

%Tarjeta Verde
usar(alcohol_etilico_70_porciento,tarjeta_verde).

%Tarjeta Azul
usar(respirador_N95,tarjeta_azul).

%Cuadro 2 Tarjeta Color Verde
medidas_gotas(distancia,1_metro).
medidas_gotas(puerta_cerrada,atencion).
medidas_gotas(visitante,reportarse,enfermeras).
medidas_gotas(equipo_medico,desechable).
medidas_gotas(equipo_medico,personalizado).
medidas_gotas(compartir_equipo_medico,limpiar,desinfectar).
medidas_gotas(habitacion_individual).
medidas_gotas(transportar_paciente).
medidas_gotas(notificar_area).

%Cuadro 2 Tarjeta Color Azul
medias_aerosoles()

cubrise(boca).
cubrise(nariz).

accion(tocer).
accion(estornudar).
accion(limpiar,tarjeta_verde).
accion(desinfectar,tarjeta_verde).

%//////////////////////////////////////////////////////Rules

caso_sospechoso(E1,E2,E3,C1,C2,C3,P1,P2):-
    enfermedad_covid(E1,E2,E3),contacto_covid(C1,C2,C3);pais_transmision_covid(P1,P2).

caso_confirmado(E1,E2,E3,C1,C2,C3,P1,P2,Y,Z) :-
    caso_sospechoso(E1,E2,E3,C1,C2,C3,P1,P2),!,diagnostico(Y,Z).

vigilancia_epidemiologica(X) :-
    %Definicion operacional
    write('caso sospechozo o caso confirmado'),
    caso_sospechoso(_,_,_,_,_,_,_,_);caso_confirmado(_,_,_,_,_,_,_,_,_,_),objetivo_vigilancia_covid(X).

%TODO with rules above
% medidas_preventivas()

% 1 Step for medias_preventivas
interrogatorio_atencion_covid(X) :-
    unidad_salud(C1,C2,C3,C4),personal_medico(M1,de_primer_contacto),caso_sospechoso(_,_,_,_,_,_,_,_).

proveer_mascarilla_quirurjica(X):-
    sintomas_covid(sintoma,respiratorio),
    usar(X,tolera).

higiene_respiratoria(X,Y) :-
    sintomas_covid(sintoma,respiratorio),
    usar(X,no_tolera),
    accion(Y).

% 2 Step for medias_preventivas without synthoms
jurisdiccion_sanitaria(X,Y,Z,W) :-
    atencion_medica(X),
    estudio_epidemiologico(Y),
    institucion_epidemiologica(Z),
    personal_medico(W,coordinacion_jurisdiccion_sanitaria).

% 3 Step for medias_preventivas for breath synthoms
jurisdiccion_sanitaria_sintomas(X,Y,Z,T1,T2,T3) :-
    atencion_medica(X),
    estudio_epidemiologico(Y),
    institucion_epidemiologica(Z),
    sintomas_covid(sintoma,respiratorio),
    proveer_mascarilla_quirurjica(T1);higiene_respiratoria(T2,T3).

%definicion_operacional
%--------------------------------Page 11---------------------------------