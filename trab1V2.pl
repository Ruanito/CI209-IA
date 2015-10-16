moeda_diferente([A,B,C,D,E,F,G,H,I,J,M,N], P, Z) :- 
	soma([A,B,C,D], S),
	soma([E,F,G,H], V),
	V =:= S -> iguais([A,B,C,I,J,M,N], Q, Z), posicao(Q, [A,B,C,D,E,F,G,H,I,J,M,N], P); tchau([]),
	soma([A,B,C,D], S),
	soma([E,F,G,H], V),
	V > S -> naoiguais([A,B,C,D,E,F,G,H,J], Q, Z), posicao(Q, [A,B,C,D,E,F,G,H,I,J,M,N], P); tchau([]),
	soma([A,B,C,D], S),
	soma([E,F,G,H], V),
	S > V -> naoiguais([E,F,G,H,A,B,C,D,J], Q, Z), posicao(Q, [A,B,C,D,E,F,G,H,I,J,M,N], P).

iguais([A,B,C,I,J,M,N], P, Z) :-
	soma([A,B,C], S),
	soma([I,J,M], V),
	V =:= S -> leveoupesado(A,N,P,Z); tchau([]),
	soma([A,B,C], S),
	soma([I,J,M], V),
	V > S -> pesado(I,J,M,P,Z); tchau([]),
	soma([A,B,C], S),
	soma([I,J,M], V),
	V < S -> leve(I,J,M,P,Z).

naoiguais([A,B,C,D,E,F,G,H,J], P, Z) :-
	soma([A,B,E], S),
	soma([C,F,J], V),
	S =:= V -> iguaisiguais(G,H,D,P,Z); tchau([]),
	soma([A,B,E], S),
	soma([C,F,J], V),
	V > S -> levepesado(A,B,F,P,Z); tchau([]),
	soma([A,B,E], S),
	soma([C,F,J], V),
	S > V -> pesadoleve(C,J,E,P,Z).

pesadoleve(C,J,E,P,Z) :-
	C =:= J -> P is E, Z = 'Mais pesada ?yes'; tchau([]),
	J > C -> P is C, Z = 'Mais pesada ?no'.

levepesado(A,B,F,P,Z) :-
	A =:= B -> P is F, Z = 'Mais pesada ?yes'; tchau([]),
	A > B -> P is B, Z = 'Mais pesada ?no'; tchau([]),
	B > A -> P is A, Z = 'Mais pesada ?no'. 

iguaisiguais(G,H,D,P,Z) :-
	G =:= H -> P is D, Z = 'Mais pesada ?no'; tchau([]),
	G > H -> P is G, Z = 'Mais pesada ?yes'; tchau([]),
	H > G -> P is H, Z = 'Mais pesada ?yes'.

leveoupesado(A,N,P,Z) :-
	A > N -> P is N, Z = 'Mais pesada ?no'; tchau([]),
	N > A -> P is N, Z = 'Mais pesada ?yes'.

pesado(I,J,M,P,Z) :-
	I > J -> P is I, Z = 'Mais pesada ?yes'; tchau([]),
	J > I -> P is J, Z = 'Mais pesada ?yes'; tchau([]),
	I =:= J -> P is M, Z = 'Mais pesada ?yes'; tchau([]).

leve(I,J,M,P,Z) :-
	I < J -> P is I, Z = 'Mais pesada ?no'; tchau([]),
	J < I -> P is J, Z = 'Mais pesada ?no'; tchau([]),
	I =:= J -> P is M, Z = 'Mais pesada ?no'; tchau([]).

soma([],0).
soma([X|H], S) :-
	soma(H, R),
	S is X + R.

posicao(E,[E|_],1):-
	!.
posicao(E,[_|T],I):- 
	posicao(E,T,X),
	I is X + 1.

tchau([]).