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
condorcetW(A) :- M = #max{N:numPre(_,N)},numPre(A,M).
condorcetWinner(1) :- condorcetW(A),condorcetW(B), A!=B.

sumAlter(X):- X = #count{N : rank(_,N,_)}.
borda(X,Y,Z) :- rank(X,Y,A), Z = (N - A), sumAlter(N).
bordaSum(Y,Z) :- borda(_,Y,_), Z = #sum{N,X: borda(X,Y,N)}.
bordaWinner(A) :- M = #max{N:bordaSum(_,N)},bordaSum(A,M).

win(X) :- condorcetW(X), not condorcetWinner(1).
win(X) :- bordaWinner(X), X = #min{Z: bordaWinner(Z)}, condorcetWinner(1).
#show.
#show win/1.