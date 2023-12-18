edges (X,Y) :- edge(X,Y).
edges (X,Y) :- edges(Y,X).
center1(A) :- edges(X,A), edges(Y,A), edges(Z,A), X != Y, Y != Z, X != Z.
1 {center(X): center1(X)} 1 :- center1(Y).
1 {center(X): vertex(X)} 1 :- not center1(Y), vertex(Y).

{leg(X,Y)} :- edge(X,Y).

path(X,Y) :- edges(X,Y).
path(X,Z) :- path(X,Y), path(Y,Z).
reachable(Y) :- path(X,Y), center(X), vertex(Y).

degree (V, D) :- vertex(V), D = #count{ U: leg(U, V); U: leg(V, U) }.
:- center(X), degree(X,D), D<2.
:- not center(X), degree(X,D), D>2.
:- degree (X, D), vertex(X), D = 0.
legs(X,Y) :- leg(X,Y).
legs(X,Y) :- legs(Y,X).
legs(X,Z) :- legs(X,Y), legs(Y,Z).
:- not legs(X,Y), vertex(X), vertex(Y).
:- not reachable(X), vertex(X).
numv(X) :- X = #count{ V: vertex(V) }.
numl(X) :- X = #count{ V,W: leg(V,W) }.
:- numv(X), numl(Y), not Y < X.
#show.
#show center/1.
#show reachable/1.
#show leg/2.
