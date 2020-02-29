% ASP 15-puzzle solving

% initialization
#const c=1.
state(X,Y,N,0) :- cell(X,Y,N).

% move generator
{move(0..3,0..3,1..c)}c. 
1 {move(0..3,0..3,T)} 1 :- move(X,Y,T+1), T>0. 

% state transitions
state(X,Y,0,T) :- move(X,Y,T). 										% move of empty field
state(X,Y,N,T+1) :- state(X,Y,0,T), state(A,B,N,T), move(A,B,T+1).					% move of cell to previous empty field
state(U,V,N,T+1) :- state(X,Y,0,T), move(A,B,T+1), state(U,V,N,T), (U,V) != (A,B), (U,V) != (X,Y).   	% static cells (no movement for T -> T+1)

% soft constraints
#minimize{1,T : move(X,Y,T)}.

% hard constraints
:- move(X,Y,T), move(Z,Y,T), Z != X.				% only one move per row and time step
:- move(X,Y,T), move(X,Z,T), Z != Y.				% only one move per column and time step
:- move(X,Y,T+1), state(X,Y,0,T).				% a move has to change the position of the empty field
:- move(X,Y,T+1), move(A,B,T), X != A, Y != B.			% move for next time step has to share column or row with previous one
:- move(X,Y,T+1), move(A,B,T), X = A, Y != B+1, Y != B-1. 	% move for next time step needs change vertical position by a unit if horizontal position reamins compared to the previous move  
:- move(X,Y,T+1), move(A,B,T), Y = B, X != A+1, X != A+1.	% move for next time step needs change horizontal position by a unit if vertical position reamins compared to the previous move

% goal condition
lastmove(0). 
lastmove(M) :- M = #max{T : move(X,Y,T)}.
:- state(0,0,N,M), M = #max{Q : lastmove(Q)}, N != 1.
:- state(0,1,N,M), M = #max{Q : lastmove(Q)}, N != 2.
:- state(0,2,N,M), M = #max{Q : lastmove(Q)}, N != 3.
:- state(0,3,N,M), M = #max{Q : lastmove(Q)}, N != 4.
:- state(1,0,N,M), M = #max{Q : lastmove(Q)}, N != 5.
:- state(1,1,N,M), M = #max{Q : lastmove(Q)}, N != 6.
:- state(1,2,N,M), M = #max{Q : lastmove(Q)}, N != 7.
:- state(1,3,N,M), M = #max{Q : lastmove(Q)}, N != 8.
:- state(2,0,N,M), M = #max{Q : lastmove(Q)}, N != 9.
:- state(2,1,N,M), M = #max{Q : lastmove(Q)}, N != 10.
:- state(2,2,N,M), M = #max{Q : lastmove(Q)}, N != 11.
:- state(2,3,N,M), M = #max{Q : lastmove(Q)}, N != 12.
:- state(3,0,N,M), M = #max{Q : lastmove(Q)}, N != 13.
:- state(3,1,N,M), M = #max{Q : lastmove(Q)}, N != 14.
:- state(3,2,N,M), M = #max{Q : lastmove(Q)}, N != 15.
:- state(3,3,N,M), M = #max{Q : lastmove(Q)}, N != 0. 

% output
#show move/3.
