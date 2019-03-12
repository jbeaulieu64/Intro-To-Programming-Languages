/*
    COMP3071 LA3 - Prolog introduction
*/

/* insert your clauses here */
isGod(tom_brady).
likestom_brady(josh).
onlywatchoffense(will).
trash(browns).
trash(jets).
likescoorlite(deepak).

worshipsbrady(A):-likestom_brady(A),not(onlywatchoffense(A)).
isfakefan(B):-likescoorlite(B); onlywatchoffense(B).
isdisiple(C,D):-isGod(C),likestom_brady(D).
istrash(E):- trash(E).



/* put your example queries in this comment under your clauses
istrash(patriots)
worshipsbrady(will)
isdisiple(tom_brady,F)






*/
