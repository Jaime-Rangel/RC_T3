% Motor de inferencia para Marcos

value(Frame,Slot,Value) :-
    Query =.. [Frame,Slot,Value],
    Query, !. % valor encontrado directamente.

value(Frame,Slot,Value) :-
    parent(Frame,ParentFrame), % Un marco más general
    value(ParentFrame,Slot,Value).


parent(Frame,ParentFrame) :-
    (Query =.. [Frame, a_kind_of, ParentFrame]
    ;
    Query =.. [Frame, instance_of, ParentFrame]
    ),
    Query.
