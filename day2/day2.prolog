:- set_prolog_flag(double_quotes, chars).

%% $ gprolog --version
%% Prolog top-Level (GNU Prolog) 1.5.0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             Utils                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sum([], 0).
sum([H|T], S) :-
  sum(T, S1),
  S #= H + S1.

gameId(GameId) :- game(GameId, _, _).

rgbColor(rgb(R, _, _), red, R) :- !.
rgbColor(rgb(_, G, _), green, G) :- !.
rgbColor(rgb(_, _, B), blue, B).

rgbColors(rgb(R, G, B), [R, G, B]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     Constraining BagCubes                      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

postRequiredCubesForColor(GameId, BagCubes, Color) :-
  rgbColor(BagCubes, Color, BagCubesOfColor),
  GameColorQ =.. [Color, Q],
  findall(Q, game(GameId, _, GameColorQ), Qs),
  maplist(#>=(BagCubesOfColor), Qs).

postRequiredCubes(GameId, BagCubes) :-
  maplist(postRequiredCubesForColor(GameId, BagCubes), [red, green, blue]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            Part A                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

partABagCubes(rgb(12, 13, 14)).

partAPossGame(GameId) :-
  partABagCubes(BagCubes),
  postRequiredCubes(GameId, BagCubes).

partApossibleGameIds(GameIds, Sum) :-
  setof(GameId, (gameId(GameId), partAPossGame(GameId)), GameIds),
  sum(GameIds, Sum).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            Part B                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

partBMinimumBagCubes(GameId, BagCubes) :-
  postRequiredCubes(GameId, BagCubes),
  rgbColors(BagCubes, Xs),
  once(fd_labeling(Xs)).

partBpowerOfBagCubes(rgb(R, G, B), Power) :-
  Power #= R * G * B.

partBPowers(Powers, Sum) :-
  setof(GameId, gameId(GameId), GameIds),
  findall(Power, (member(GameId, GameIds),
                  partBMinimumBagCubes(GameId, BagCubes),
                  partBpowerOfBagCubes(BagCubes, Power)),
          Powers),
  sum(Powers, Sum).
