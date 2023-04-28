% Motor inferencial para marcos V2: Incluye funciones

value(Frame,Slot,Value) :-
    value(Frame, Frame, Slot, Value).

value(Frame, SuperFrame, Slot, Value) :-
    Query =.. [SuperFrame, Slot, ValAux],
    Query,
    process(ValAux, Frame, Value), !.

value(Frame, SuperFrame, Slot, Value) :-
    parent(SuperFrame, ParentSuperFrame),
    value(Frame, ParentSuperFrame, Slot, Value).

parent(Frame,ParentFrame) :-
    (Query =.. [Frame, a_kind_of, ParentFrame]
    ;
    Query =.. [Frame, instance_of, ParentFrame]
    ),
    Query.

process(execute(Proc, Frame, Value), Frame, Value) :- !,
    Proc.

process(Value,_,Value).  % un valor, no un procedimiento.
