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
unidad_casa(casa,aislado,ventilado,puerta_cerrada).

unidad_medica(publica).
unidad_medica(privada).
atencion_medica(primer_nivel).
atencion_medica(segundo_nivel).
atencion_medica(tercer_nivel).

%Coordination jurisdiccion sanitaria
estudio_epidemiologico(llenado_del_estudio).
institucion_epidemiologica(toma_de_muestra).

usar_mascarilla_tolera(mascarilla_quirurgica_desechable,tolera).
usar_mascarilla_tolera(papel_higienico,no_tolera).
usar_guantes(guantes,tarjeta_roja).
usar_mascarillla(mascarilla_proteccion_facial,salpicadura,tarjeta_roja).
usar_bata(bata_impermeable,salpicadura,contaminacion,tarjeta_roja).
usar_agua(agua,jabon,lavado,tarjeta_roja).
usar_alcohol_gel(alcohol_gel_70_porciento,higiene,tarjeta_roja).
usar_bolsa(bolsa_plastico,rojo,contaminacion_ropa,tarjeta_roja).
usar_alcohol_etilico(alcohol_etilico_70_porciento,tarjeta_verde).
usar_respirador(respirador_N95,tarjeta_azul).
usar_contenedor(contenedor_rigido,desecho,contaminacion,tarjeta_roja).

%Cuadro 2 Tarjeta Color Verde
aislamiento_habitacion(habitacion_individual,disponible).
aislamiento_transportar(paciente,proposito_indispensable,usar_mascarilla_tolera(mascarilla_quirurgica_desechable,tolera)).
aislamiento_notificar(area,precauciones).
aislamiento_personal(separacion,voluntaria).

medida_mantener(distancia_1_metro).
medida_mantener(puerta_cerrada).

reportarse(visitante,central_enfermeras).

hospitalizacion(no_requiere_hospitalizacion).
hospitalizacion(requiere_hospitalizacion).

cubrise(boca).
cubrise(nariz).

accion(tocer).
accion(estornudar).
accion(limpiar,tarjeta_verde).
accion(desinfectar,tarjeta_verde).
accion(lavado,manos,tarjeta_roja).
accion(higiene,manos,tarjeta_roja).
accion(ponerse,guantes,tarjeta_roja).

contacto(sangre,liquido).
contacto(secreciones,liquido).
contacto(articulo_contaminado,objeto).
contacto(membranas_mucosas,objeto).
contacto(heridas_piel,objeto).

riesgo_salpicadura_en(salpicadura,ojos).
riesgo_salpicadura_en(salpicadura,cara).

contaminacion_de(contaminacion,piel).
contaminacion_de(contaminacion,ropa).

desechos_de(agujas).
desechos_de(material_punzocortante).

numero_pacientes(unico).
numero_pacientes(multiples).

garantizar(insumos).

notificacion(formato_suive-1).

movimiento_personas(separacion,movimiento).
movimiento_personas(restriccion,movimiento).

%Cuadro 2 Tarjeta Color Azul
aerosoles(procedimiento,[aspiraciones,intubaciones,broncoscopias,reanimacion_cardiopulmonar]).

%//////////////////////////////////////////////////////Rules

caso_sospechoso(E1,E2,E3,C1,C2,C3,P1,P2):-
    enfermedad_covid(E1,E2,E3),contacto_covid(C1,C2,C3);pais_transmision_covid(P1,P2),
    estudio_epidemiologico(_).

caso_confirmado(E1,E2,E3,C1,C2,C3,P1,P2,Y,Z) :-
    caso_sospechoso(E1,E2,E3,C1,C2,C3,P1,P2),!,diagnostico(Y,Z).

vigilancia_epidemiologica(X) :-
    %Definicion operacional
    write('caso sospechozo o caso confirmado'),
    caso_sospechoso(_,_,_,_,_,_,_,_);caso_confirmado(_,_,_,_,_,_,_,_,_,_),objetivo_vigilancia_covid(X).

% 1 Step for medias_preventivas
interrogatorio_atencion_covid(C1,C2,C3,C4) :-
    unidad_salud(C1,C2,C3,C4),personal_medico(_,de_primer_contacto),caso_sospechoso(_,_,_,_,_,_,_,_).

proveer_mascarilla_quirurjica(X):-
    sintomas_covid(sintoma,respiratorio),
    usar_mascarilla_tolera(X,tolera).

higiene_respiratoria(X,Y) :-
    sintomas_covid(sintoma,respiratorio),
    usar_mascarilla_tolera(X,no_tolera),
    accion(Y).

% 2 Step for medias_preventivas without synthoms
jurisdiccion_sanitaria(X,Y,Z,W) :-
    atencion_medica(X),X == primer_nivel,
    estudio_epidemiologico(Y),
    institucion_epidemiologica(Z),
    sintomas_covid(sintoma,ninguno),
    personal_medico(W,coordinacion_jurisdiccion_sanitaria).

% 3 Step for medias_preventivas for breath synthoms
jurisdiccion_sanitaria_sintomas(X,Y,Z,T1,T2,T3) :-
    atencion_medica(X),X== primer_nivel,
    estudio_epidemiologico(Y),
    institucion_epidemiologica(Z),
    sintomas_covid(sintoma,respiratorio),
    proveer_mascarilla_quirurjica(T1);higiene_respiratoria(T2,T3).

%TODO with rules below
higiene_manos(X,Y,W,Z) :-
    write('lavado manos agua y jabon'),
    (accion(X,Y,tarjeta_roja),usar_agua(Z,W,X,tarjeta_roja),X \== higiene);
    write('o higiene manos y alcohol'),
    (accion(X,Y,tarjeta_roja),usar_alcohol_gel(Z,X,tarjeta_roja),X == higiene).

guantes(X,Y) :-
    higiene_manos(_,_,_,_),
    contacto(X,_),
    usar_guantes(Y,_).

salpicadura_liquidos(X,Y,Z) :-
    contacto(X,liquido),
    write('Salpicadura de liquido:'),
    riesgo_salpicadura_en(Y,Z).

mascarilla(X,Y) :-
    salpicadura_liquidos(_,Y,_),
    !, %not all cases
    usar_mascarillla(X,Y,tarjeta_roja).

bata(X,Y,Z,B) :-
    contaminacion_de(X,Y),
    salpicadura_liquidos(_,Z,_),
    !,%not all cases
    usar_bata(B,Z,X,tarjeta_roja).

transporte_ropa(X,K,Y,W) :-
    contaminacion_de(X,K),K == ropa,
    usar_bolsa(Y,W,contaminacion_ropa,_).

contenedor(X,Y,Z) :-
    usar_contenedor(Y,Z,_,_),
    desechos_de(X).

precauciones_aerosol(X,K,Y) :-
    (usar_respirador(X,_),
    aerosoles(K,Y));
    (write('caso confirmado'),usar_respirador(X,_),
    aerosoles(K,Y),caso_confirmado(_,_,_,_,_,_,_,_,_,_)).


% 4 Step for gota y contacto
personal_primer_contacto() :-
    unidad_medica(publica),unidad_medica(privada),
    caso_sospechoso(_,_,_,_,_,_,_,_).

% 5 Step
caso_detectado(X,Y,Z) :-
    atencion_medica(X),X \= primer_nivel,
    personal_medico(Y,Z),Z == coordinacion_jurisdiccion_sanitaria.


%Rules for table 2
aislamiento(X,W,K) :-
    (write('separacion'),movimiento_personas(X,_),X == separacion,enfermedad_covid(W,K,_));
    (write('restriccion'),movimiento_personas(X,_),X == restriccion,enfermedad_covid(W,K,_)).

caso_aislamiento(X,W,K,C) :-
    (write('separacion'),movimiento_personas(X,_),X == separacion,enfermedad_covid(W,K,_),unidad_casa(C,_,_,_));
    (write('restriccion'),movimiento_personas(X,_),X == restriccion,enfermedad_covid(W,K,_),unidad_salud(C,_,_,_)).

aislamiento_casa_habitacion(X,W,K,H) :-
    enfermedad_covid(W,K,_),hospitalizacion(X),X == no_requiere_hospitalizacion,aislamiento_habitacion(H,_).

aislamiento_casa(X,W,K,P,R,T) :-
    enfermedad_covid(W,K,_),hospitalizacion(X),X == no_requiere_hospitalizacion,higiene_manos(R,T,_,_),!,
    higiene_respiratoria(_,_),!,usar_mascarilla_tolera(P,tolera).

aislamiento_voluntario(X,W,K,C,T) :-
    (write('separacion'),movimiento_personas(X,_),X == separacion,aislamiento_personal(_,T),enfermedad_covid(W,K,_),unidad_casa(C,_,_,_));
    (write('restriccion'),movimiento_personas(X,_),X == restriccion,aislamiento_personal(_,T),enfermedad_covid(W,K,_),unidad_salud(C,_,_,_)).

%Step 6
paciente_aislado(W,K,C,R,T,F) :-
    enfermedad_covid(W,K,_),unidad_salud(C,_,_,_),aislamiento_habitacion(R,_),numero_pacientes(T),T == unico,garantizar(F).

multiples_pacientes_aislados(W,K,C,R,T,F) :-
    enfermedad_covid(W,K,_),unidad_salud(C,_,_,_),aislamiento_habitacion(R,_),numero_pacientes(T),T == multiples,
    medida_mantener(F),F == distancia_1_metro.

%Step 7
caso_identificado(X,Y,Z) :-
    institucion_epidemiologica(Z), personal_medico(X,Y).

%Step 9 and 10
caso_corroborado_sospechoso(X,Y) :-
    caso_sospechoso(_,_,_,_,_,_,_,_),!,
    estudio_epidemiologico(X),notificacion(Y).

