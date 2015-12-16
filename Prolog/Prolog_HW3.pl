child(stitch,nemo).
child(stitch,evilqueen).
child(minnie,evilqueen).
child(minnie,nemo).
child(pooh,anna).
child(pooh,olaf).
child(hercules,minnie).
child(hercules,pooh).
child(cinderella,minnie).
child(cinderella,pooh).
child(charmingprince,hercules).
child(charmingprince,belle).
child(walle,belle).
child(walle,hercules).
child(aladdin,charmingprince).
child(elsa,mulan).
child(mulan,hercules).
child(mulan,cinderella).
child(baymax,olaf).
child(dory,pooh).
child(dory,pocahontas).
child(littlemermaid,minnie).
child(littlemermaid,pooh).
child(snowwhite,littlemermaid).
child(snowwhite,beast).
child(belle,mickey).
child(anna,olaf).
child(mickey,anna).

female(littlemermaid).
female(snowwhite).
female(pocahontas).
female(evilqueen).
female(minnie).
female(anna).
female(belle).
female(cinderella).
female(mulan).
female(elsa).
female(dory).

male(mickey).
male(beast).
male(nemo).
male(stitch).
male(pooh).
male(olaf).
male(hercules).
male(charmingprince).
male(walle).
male(aladdin).

mother(X,Y) :- child(Y,X), female(X).
parent(X,Y) :- child(Y,X).
grand_parent(X,Z) :- parent(X,Y), parent(Y,Z).
great_grand_mother(X,Z) :- mother(X,Y), grand_parent(Y,Z).
great_grand_parent(X,Z) :- parent(X,Y), grand_parent(Y,Z).

sibling(X,Y) :- child(X,Z), child(Y,Z).
brother(X,Y) :- sibling(X,Y), male(X).
sister(X,Y) :- sibling(X,Y), female(X).

half_sibling(X,Y) :- child(X,Z), child(X,A), child(Y,Z), child(Y,B), \+ A=B.
full_sibling(X,Y) :- child(X,P1), child(X,P2), child(Y,P1), child(Y,P2), \+ P1=P2.

first_cousin(X,Y) :- grand_parent(Z,X), grand_parent(Z,Y).
second_cousin(X,Y) :- great_grand_parent(Z,X), great_grand_parent(Z,Y).

half_first_cousin(X,Y) :- child(X,Z), child(Y,M), half_sibling(Z,M).
double_first_cousin(X,Y) :- child(X,P1), child(X,P2), \+ P1=P2, child(Y,Z), sibling(P1,Z), sibling(P2,Z).

first_cousin_twice_removed(X,Y) :- grand_parent(Z,Y), first_cousin(X,Z).

descendant(X,Y) :- child(X,Y).
descendant(X,Y) :- child(X,Z), descendant(Z,Y).
ancestor(X,Y) :- descendant(Y,X).

cousin(X,Y) :- child(X,A), child(Y,B), sibling(A,B), \+ A=B.
cousin(X,Y) :- child(X,A), child(Y,B), \+ A=B, sibling(A,Z), cousin(Z,B).

closest_common_ancestor(X,Y,Z) :- ancestor(X,Y), ancestor(X,Z), \+ Y=Z, child(C,X), \+ ancestor(C,Y), \+ ancestor(C,Z). 

write_child(X,Y) :- write(X), write(' is a child of '), write(Y), nl.
write_descendant_chain(X,Y) :- child(X,Y), write_child(X,Y).
write_descendant_chain(X,Y) :- child(X,Z), write_descendant_chain(Z,Y), write_child(X,Z).  
