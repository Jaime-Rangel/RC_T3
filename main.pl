:- consult('universe.pl'). % consult the Prolog file with the norms

supported_by_norms :-
    norma_sustentada('COVID-19 constituye un riesgo a la salud de la población por considerarse una enfermedad emergente con riesgo alto de introducción al territorio mexicano.', ley_general_de_salud),
    norma_sustentada('COVID-19 constituye un riesgo a la salud de la población por considerarse una enfermedad emergente con riesgo alto de introducción al territorio mexicano.', nom_017_ssa_2_2012),
    norma_sustentada('COVID-19 constituye un riesgo a la salud de la población por considerarse una enfermedad emergente con riesgo alto de introducción al territorio mexicano.', reglamento_sanitario_internacional).
    
    % the statement is supported by the norms if all three norms are sustained by the text
