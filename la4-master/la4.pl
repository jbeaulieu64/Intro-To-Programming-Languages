% COMP3071 - LA4

/********************************************
** define your three predicates below here **
********************************************/

married(jeff, mark).
male(mark).
sibling(jeff,tina).

brotherInLaw(Bro, You) :- married(You, Sib), sibling(Sib, Bro), male(Bro).
brotherInLaw(Bro, You) :- married(Sib, Bro), sibling(Sib, You), male(Bro).

uniques(In, Out) :- sort(In, Out).

holes(L,M) :- findall(X, (append(_, [I,J|_], L), I1 is I+1, J1 is J-1, between(I1,J1,X)), M).
