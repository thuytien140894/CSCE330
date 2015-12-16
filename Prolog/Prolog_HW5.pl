exactly_3(X) :- append([_,_,_|[]],[],X).
at_least_3(X) :- append([_,_,_|_],_,X).

at_most_3(X) :- append([],[],X).
at_most_3(X) :- append([_|[]],[],X).
at_most_3(X) :- append([_,_|[]],[],X).
at_most_3(X) :- append([_,_,_|[]],[],X).

intersect(X,Y) :- member(A,X), member(A,Y).
all_intersect([],_).
all_intersect([H|T],Y) :- intersect(H,Y), all_intersect(T,Y). 