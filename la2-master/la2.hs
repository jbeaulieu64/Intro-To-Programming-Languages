module PolyLA2 (Coeff, Exp, Polynomial) where  -- defines the module name so you can import from another haskell file
type Coeff=Int
type Exp=Int
type Monomial=(Coeff, Exp)
type Polynomial=[(Coeff, Exp)] -- a list of terms in a polynomial formula

-- TODO: implement addpoly to add two polynomials
addpoly::Polynomial->Polynomial->Polynomial
addpoly p1 p2 = remZeroCoeff (addPolyBase p1 p2)
   where addPolyBase::Polynomial->Polynomial->Polynomial
         addPolyBase [] y = y
         addPolyBase x [] = x
         addPolyBase p1@((a,b):x) p2@((c,d):y)
             | b == d  = ((a+c,b):(addpoly x y))
             | b < d = ((c,d):(addpoly p1 y ))
             | b > d = ((a,b):(addpoly x p2))

-- TODO: implement multpoly to multiply two polynomials
multpoly::Polynomial->Polynomial->Polynomial
multpoly p1 p2 = remZeroCoeff (multPolyBase p1 p2)
   where multPolyBase::Polynomial->Polynomial->Polynomial
         multPolyBase [] y = []
         multPolyBase x [] = []
         multPolyBase (x:xs) p
            | (null xs) = multMono x p
            | otherwise = addpoly (multMono x p) (multPolyBase xs p)
            where multMono::Monomial->Polynomial->Polynomial
                  multMono m@(c1,e1) ((c2,e2):t)
                        | (null t) = [(c1*c2, e1+e2)]
                        | otherwise = [(c1*c2, e1+e2)] ++ (multMono m t)

remZeroCoeff::Polynomial->Polynomial
remZeroCoeff [] = []
remZeroCoeff ((c,e):t) = (if c /= 0 then [(c,e)] else []) ++ (remZeroCoeff t)
