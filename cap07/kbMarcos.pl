% Base de conocimiento basada en Marcos
% Los hechos se representan como marco(ranura,valor).
% El valor puede ser un procedimiento para su cálculo.

% Marco ave: un ave prototípica

ave(a_kind_of,animal).
ave(locomocion,vuelo).
ave(actividad,diurna).

% Marco albatros: un ave prototípica con hechos extra:
% es blanco y negro; y mide 115cm

albatros(a_kind_of,ave).
albatros(color,blanco_y_negro).
albatros(tamano,115).

% Marco kiwi: un ave prototípica con hechos extra:
% camina, es nocturno, café y mide unos 40cm

kiwi(a_kind_of,ave).
kiwi(locomocion,caminata).
kiwi(actividad,nocturna).
kiwi(tamano,40).
kiwi(color,cafe).

% Marco enrique: es un albatros

enrique(instance_of,albatros).
enrique(tamano,120).

% Marco beto: es un albatros bebé

beto(instance_of,albatros).
beto(tamano,40).

% Marco ian: es un kiwi.

ian(instance_of,kiwi).

% Marco animal: su tamaño relativo se calcula ejecutando un
% procedimiento

animal(tamanoRelativo,
       execute(tamanoRelativo(Obj,Val), Obj, Val)).

% tamanoRelativo(Obj,TamRel): El tamaño relativo TamRel de Obj

tamanoRelativo(Obj,TamRel) :-
    value(Obj,tamano,TamObj),
    value(Obj,instance_of,ClaseObj),
    value(ClaseObj,tamano,TamClase),
    TamRel is (TamObj/TamClase) * 100.
