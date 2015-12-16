% Exercise 2: Color the map of France, Switzerland, Italy, Belgium, Holland, Germany, and Austria
%             such that no two countries with a border between them have the same color.


map_coloring(F,S,I,B,H,G,A) :- 	
	solution(F,S,I,B,H,G,A),
	write('France is'), write(' '), write(F), write('.'), nl,
	write('Switzerland is'), write(' '), write(S), write('.'), nl,
	write('Italy is'), write(' '), write(I), write('.'), nl,
	write('Belgium is'), write(' '), write(B), write('.'), nl,
	write('Holland is'), write(' '), write(H), write('.'), nl,
	write('Germany is'), write(' '), write(G), write('.'), nl,
	write('Austria is'), write(' '), write(A), write('.'), nl.

% solution(F,S,I,B,H,G,A) holds if F, S, I, B, H, G, A are colors that solve the map-coloring
% problem stated above.
solution(F,S,I,B,H,G,A) :-
	color(F), color(S),
	\+ F=S,
	color(I), 
	\+ F=I, \+ S=I,
	color(B),
	\+ F=B,
	color(H),
	\+ B=H,
	color(G),
	\+ B=G, \+ H=G, \+ S=G,
	color(A),
	\+ G=A, \+ S=A, \+ I=A.

% The three colors (constraints)
color(red).
color(yellow).
color(orange).

% Exercise 3: Solve the cryptarithmetic puzzle CROSS + ROADS = DANGER.

cryptarithmetic_puzzle(C,R,O,S,A,D,N,G,E) :-
	solution(C,R,O,S,A,D,N,G,E),
	write('The solution to CROSS + ROADS = DANGER is '), nl,
	write(C), write(R), write(O), write(S), write(S),
	write(' + '),
	write(R), write(O), write(A), write(D), write(S),
	write(' = '),
	write(D), write(A), write(N), write(D), write(E), write(R).

% solution(C,R,O,S,A,D,N,G,E) holds for CROSS + ROADS = DANGER.
solution(C,R,O,S,A,D,N,G,E) :- 
	dig(S),
	R is (S+S) mod 10, C1 is (S+S) // 10,
	dig(D),
	E is (S+D+C1) mod 10, C10 is (S+D+C1) // 10,
	dig(O), dig(A),
	G is (O+A+C10) mod 10, C100 is (O+A+C10) // 10,
	dig(R), R > 0,
	N is (R+O+C100) mod 10, C1000 is (R+O+C100) // 10,
	dig(C), C > 0,
	A is (C+R+C1000) mod 10, D is (C+R+C1000) // 10, D > 0, 
	uniq_digits(C,R,O,S,A,D,N,G,E).

% uniq_digits(...) holds if the arguments are all distinct digits.
uniq_digits(C,R,O,S,A,D,N,G,E) :-
	dig(C), dig(R), dig(O), dig(S), dig(A), dig(D), dig(N), dig(G), dig(E),
	\+ C=R, \+ C=O, \+ C=S, \+ C=A, \+ C=D, \+ C=N, \+ C=G, \+ C=E,
			\+ R=0, \+ R=S, \+ R=A, \+ R=D, \+ R=N, \+ R=G, \+ R=E,
					\+ O=S, \+ O=A, \+ O=D, \+ O=N, \+ O=G, \+ O=E,
							\+ S=A, \+ S=D, \+ S=N, \+ S=G, \+ S=E,
									\+ A=D, \+ A=N, \+ A=G, \+ A=E,
											\+ D=N, \+ D=G, \+ D=E,
													\+ N=G, \+ N=E,
															\+ G=E.
% The digits
dig(0). dig(1). dig(2). dig(3). dig(4). 
dig(5). dig(6). dig(7). dig(8). dig(9).

% Exercise 4: Figure the person who ordered pizza.

pizza_owner(Danny,David,Doreen,Donna,Pizza,Steak,Chicken,Lasagna,Coke,Water,Coffee,Milk) :-
	solution(Danny,David,Doreen,Donna,Pizza,Steak,Chicken,Lasagna,Coke,Water,Coffee,Milk),
	match(Pizza,Danny,'Danny'),
	match(Pizza,Donna,'Donna'),
	match(Pizza,Doreen,'Doreen'),
	match(Pizza,David,'David').

match(X,X,Name) :- write(Name), write(' ordered the pizza.').
match(X,Y,_) :- \+ X=Y.

solution(Danny,David,Doreen,Donna,Pizza,Steak,Chicken,Lasagna,Coke,Water,Coffee,Milk) :-
	uniq_pos(Coke,Water,Coffee,Milk),
	uniq_pos(Steak,Chicken,Lasagna,Pizza),
	uniq_pos(Danny,Donna,Doreen,David),

	across(Danny,David),
	across(Donna,Doreen),
	beside(Doreen,Steak),  % Doreen sat beside the person who ordered steak.
	Chicken = Coke,        % The chicken came with a Coke.
	across(Lasagna,Milk),  % The person with the lasagna sat across from the person with milk.
	\+ David = Coffee,     % David never drinks coffee.
	Donna = Water,         % Donna only drinks water.
	\+ Danny = Steak.      % Danny could not afford to order steak.

% The positional predicates
uniq_pos(P1,P2,P3,P4) :-
	pos(P1), pos(P2), pos(P3), pos(P4),
	\+ P1=P2, \+ P1=P3, \+ P1=P4,
			  \+ P2=P3, \+ P2=P4,
			            \+ P3=P4.

pos(1). pos(2). pos(3). pos(4).

beside(X,Y) :- X =:= Y-1.
beside(X,Y) :- X =:= Y+1.
across(X,Y) :- X =:= Y-2.
across(X,Y) :- X =:= Y+2. 

% Exercise 5: 
kenken(R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,
         R41,R42,R43,R44,S1,S2,S3,S4,D1,D2,D3,D4) :-
   solution(R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,
              R41,R42,R43,R44,S1,S2,S3,S4,D1,D2,D3,D4), 
   nl, write('A solution to this puzzle is'), nl, 
   printrow(R11,R12,R13,R14), printrow(R21,R22,R23,R24), 
   printrow(R31,R32,R33,R34), printrow(R41,R42,R43,R44).

% Print a row of four numbers with spaces between them. 
printrow(P,Q,R,S) :- write('  '), write(P), write(' '), write(Q),
   write(' '), write(R), write(' '), write(S), nl.

solution(R11,R12,R13,R14,R21,R22,R23,R24,R31,R32,R33,R34,
           R41,R42,R43,R44,S1,S2,S3,S4,D1,D2,D3,D4) :-
   uniq(R11,R12,R13,R14), uniq(R21,R22,R23,R24),       % rows 1,2   
   uniq(R31,R32,R33,R34), uniq(R41,R42,R43,R44),       % rows 3,4
   uniq(R11,R21,R31,R41), uniq(R12,R22,R32,R42),       % cols 1,2
   uniq(R13,R23,R33,R43), uniq(R14,R24,R34,R44),       % cols 3,4

   sub(R11,R12,S1), 
   sub(R22,R23,S2), 
   sub(R32,R33,S3), 
   sub(R43,R44,S4),
   div(R13,R14,D1), 
   div(R11,R21,D2), 
   div(R24,R34,D3), 
   div(R41,R42,D4).

% uniq holds if P,Q,R,S are all distinct nums (from 1 to 4).
uniq(P,Q,R,S) :- num(P),  num(Q),  num(R),  num(S),  
                 \+ P=Q, \+ P=R, \+ P=S, \+ Q=R, \+ Q=S, \+ R=S.

% The four numbers to go into each cell
num(1).  num(2).  num(3).  num(4).

sub(X,Y,Z) :- Z =:= X-Y.
sub(X,Y,Z) :- Z =:= Y-X.
div(X,Y,Z) :- Z =:= X/Y.
div(X,Y,Z) :- Z =:= Y/X.

% Exercise 6:

quiz_solution(A1,A2,A3,A4,A5) :-
	answer(A1), answer(A2), answer(A3), answer(A4), answer(A5),

	grade(true,true,false,true,false,A1,A2,A3,A4,A5,N1), 
	grade(false,true,true,true,false,A1,A2,A3,A4,A5,N2),
	grade(true,false,true,true,false,A1,A2,A3,A4,A5,N3),
	grade(false,true,true,false,true,A1,A2,A3,A4,A5,N4),
	grade(true,false,true,false,true,A1,A2,A3,A4,A5,N5),
	N3 > N1,
	N4 > N2,
	\+ N5=5,
	\+ N5=0.

grade(S1,S2,S3,S4,S5,A1,A2,A3,A4,A5,N) :- 
	match(S1,A1,N1,1), 
	match(S2,A2,N2,1),
	match(S3,A3,N3,1),
	match(S4,A4,N4,1),
	match(S5,A5,N5,1),
	N is N1+N2+N3+N4+N5.

match(X,X,N,Increment) :- N=Increment.
match(X,Y,N,Increment) :- \+ X=Y, N is Increment-1.

answer(true). answer(false).
