% COMP3071 - PA2

when_(1000,10).
when_(1200,12).
when_(3400,11).
when_(3350,12).
when_(2350,11).
where(1000,dobbs102).
where(1200,dobbs118).
where(3400,wentw216).
where(3350,wentw118).
where(2350,wentw216).
enroll(mary,1200).
enroll(john,3400).
enroll(mary,3350).
enroll(john,1000).
enroll(jim,1000).


/************************************
*****                           *****
***** In your final submission, *****
***** leave the text above this *****
*****    comment untouched.     *****
*****                           *****
************************************/



/*************************************
** define your four predicates here **
*************************************/
scedule(S,CR,T):- enroll(S, CN), where(CN,CR),when_(CN,T).
usage(CR,T):- where(CN,CR),when_(CN,T).
conflict(CN1,CN2):- where(CN1,CR), where(CN2,CR).
meet(S1,S2):- enroll(S1,CN), enroll(S2,CN).
meet(S1,S2):- enroll(S1,CN1), enroll(S2,CN2), dif(CN1,CN2),
    where(CN1,CR), where(CN2,CR), when_(CN1,T1), when_(CN2,T2),
    (T1 is T2 +1 ; T1 is T2 -1).
