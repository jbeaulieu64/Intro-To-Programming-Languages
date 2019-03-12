/*
    COMP3071 LA3 - Prolog introduction
    trains!
*/

station(hamburg).
station(bremen).
station(hannover).
station(berlin).
station(leipzig).
station(osnabruck).
station(stuttgart).
station(fulda).
station(munich).

adjacent(hamburg, bremen).
adjacent(hamburg, berlin).
adjacent(berlin, hannover).
adjacent(berlin, leipzig).
adjacent(leipzig, fulda).
adjacent(fulda, hannover).
adjacent(hannover, osnabruck).
adjacent(osnabruck, bremen).
adjacent(stuttgart, munich).

/* insert your clauses here */
adjacent_(A,B):- adjacent(A,B).
adjacent_(A,B):- adjacent(B,A).
/*
* Gets a path from B - A with traverse than its reversed
*/
connected(A,B):- connected_(A,B,Path).
connected_(A,B,Path):- traverse(A,B,[A],Q), reverse(Q,Path).
/*
* Traverses adjacent_ stations, to construct a path from A to B
*/
traverse(A,B,P,[B|P]):- adjacent_(A,B).
traverse(A,B,Visited,Path):- adjacent_(A,C), C \== B,
        \+member(C,Visited),traverse(C,B,[C|Visited],Path).
