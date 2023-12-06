:- set_prolog_flag(double_quotes, chars).

... --> [] | [_], ... .

seq([]) --> [].
seq([H|T]) --> [H], seq(T).

digit(_,1) --> "1". digit(_,2) --> "2". digit(_,3) --> "3". digit(_,4) --> "4". digit(_,5) --> "5".
digit(_,6) --> "6". digit(_,7) --> "7". digit(_,8) --> "8". digit(_,9) --> "9".

digit(partB,1) --> "one". digit(partB,2) --> "two". digit(partB,3) --> "three".
digit(partB,4) --> "four". digit(partB,5) --> "five". digit(partB,6) --> "six".
digit(partB,7) --> "seven". digit(partB,8) --> "eight". digit(partB,9) --> "nine".

nondigits(P) --> seq(S), { \+ phrase((..., digit(P, _), ...), S) }.

firstDigit(P, D) --> nondigits(P), digit(P, D), ... .
lastDigit(P, D) --> ..., digit(P, D), nondigits(P).

%% lineValue(P, L, X) :-
%%   phrase(firstDigit(P, A), L),
%%   phrase(lastDigit(P, Z), L),
%%   X #= A * 10 + Z.

sumFirstLast(Ds, S) :-
  [First|_] = Ds,
  reverse(Ds, Ds1),
  [Last|_] = Ds1,
  S #= First * 10 + Last.

lineValue(P, L, X) :-
  findall(D, phrase((..., digit(P, D), ...), L), Ds),
  sumFirstLast(Ds, X).

sum([], 0).
sum([H|T], X) :-
  sum(T, X1),
  X #= H + X1.

docValues(P, Doc, Xs) :-
  findall(X, (call(Doc, L), once(lineValue(P, L, X))), Xs).

docSum(P, Doc, S) :-
  docValues(P, Doc, Xs),
  sum(Xs, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             PartA                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

calibrationTestDocPartA("1abc2").
calibrationTestDocPartA("pqr3stu8vwx").
calibrationTestDocPartA("a1b2c3d4e5f").
calibrationTestDocPartA("treb7uchet").

calibrationTestDocPartASum(S) :-
  docSum(partA, calibrationTestDocPartA, S).

%% | ?- calibrationTestDocPartASum(S).

%% S = 142

%% yes

calibrationDocSumPartA(S) :-
  docSum(partA, calibrationDoc, S).

%% | ?- calibrationDocSumPartA(Sum).

%% Sum = 55002

%% (33 ms) yes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             PartB                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

calibrationTestDocPartB("two1nine").
calibrationTestDocPartB("eightwothree").
calibrationTestDocPartB("abcone2threexyz").
calibrationTestDocPartB("xtwone3four").
calibrationTestDocPartB("4nineeightseven2").
calibrationTestDocPartB("zoneight234").
calibrationTestDocPartB("7pqrstsixteen").

calibrationTestDocPartBSum(S) :-
  docSum(partB, calibrationTestDocPartB, S).

%% | ?- calibrationTestDocPartBSum(S).

%% S = 281

%% yes

calibrationDocSumPartB(S) :-
  docSum(partB, calibrationDoc, S).

%% | ?- calibrationDocSumPartB(S).

%% S = 55093

%% (41 ms) yes
