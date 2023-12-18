rank(1,c,1).
rank(1,d,2).
rank(1,b,3).
rank(1,a,4).
rank(2,d,1).
rank(2,c,2).
rank(2,b,3).
rank(2,a,4).
rank(3,a,1).
rank(3,d,2).
rank(3,c,3).
rank(3,b,4).



pairwise(X, Y, Z) :- rank(X,_,_), rank(X,Y,A), rank(X,Z,B), A<B.
numPre(Y,N) :- rank(_,Y,_), N = #count{X,Z : pairwise(X, Y, Z)}.
condorcetWinner(A) :- M = #max{N:numPre(_,N)},numPre(A,M).
:- condorcetWinner(A),condorcetWinner(B),not A=B.
#show.
#show condorcetWinner/1.
