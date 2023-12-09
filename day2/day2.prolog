:- set_prolog_flag(double_quotes, chars).

%% $ gprolog --version
%% Prolog top-Level (GNU Prolog) 1.5.0

sum([], 0).
sum([H|T], S) :-
  sum(T, S1),
  S #= H + S1.

gameId(GameId) :- game(GameId, _, _).

poss(red(Q)) :- Q #=< 12.
poss(green(Q)) :- Q #=< 13.
poss(blue(Q)) :- Q #=< 14.

impossGame(GameId) :-
  game(GameId, _, C), \+ poss(C).

possibleGameIds(GameIds, Sum) :-
  setof(GameId, (gameId(GameId), \+ impossGame(GameId)), GameIds),
  sum(GameIds, Sum).
