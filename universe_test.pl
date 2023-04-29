% Fact: La vigilancia epidemiológica de COVID-19 debe enfocarse principalmente en la detección inmediata de casos importados o autóctonos.
vigilancia_epidemiologica(covid19, deteccion_inmediata, [casos_importados, casos_autoctonos]).

% Fact: Es necesario establecer un sistema altamente sensible que detecte los casos sospechosos de COVID-19 que cumplan con la definición operacional en cualquier unidad de salud (pública o privada).
sistema_sensible(sospecha_covid19, definicion_operacional, unidad_salud).

% Fact: Las acciones de vigilancia epidemiológica y por laboratorio, atención, prevención y control correspondientes deben ser dirigidas a eliminar los riesgos de transmisión del padecimiento.
acciones(vigilancia_epidemiologica, laboratorio, atencion, prevencion, control, eliminar_riesgos_transmision).

% Rule: La detección de casos sospechosos de COVID-19 debe detonar las acciones correspondientes de vigilancia epidemiológica y por laboratorio, atención, prevención y control.
detonar_acciones(Caso) :- sistema_sensible(sospecha_covid19, definicion_operacional, unidad_salud), 
                           Caso = sospecha_covid19, 
                           acciones(vigilancia_epidemiologica, laboratorio, atencion, prevencion, control, eliminar_riesgos_transmision).


% Define strategies for preventing the spread of COVID-19
strategy(1, ["promote social distancing", "encourage mask use", "increase testing"]).
strategy(2, ["implement contact tracing", "establish quarantine protocols", "provide financial assistance"]).
strategy(3, ["promote vaccination", "increase public education campaigns", "strengthen healthcare system"]).

% Determine which strategies are aligned with the guidelines for epidemiological surveillance
aligned_strategies(AlignedStrategies) :- vigilancia_epidemiologica(covid19, _, Criteria),
                                          findall(Strategy, (strategy(_, Strategy), subset(Criteria, Strategy)), AlignedStrategies).


