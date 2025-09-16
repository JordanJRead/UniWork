{-|
Module      : 1JC3-Assign1.Assign_1.hs
Copyright   :  (c) Curtis D'Alves 2022
License     :  GPL (see the LICENSE file)
Maintainer  :  none
Stability   :  experimental
Portability :  portable

Description:
  Assignment 1 -- McMaster CS 1JC3 2025.

  Modified by W. M. Farmer 13 September 2025.
-}
module Assign_1 where

-----------------------------------------------------------------------------------------------------------
-- INSTRUCTIONS              README!!!
-----------------------------------------------------------------------------------------------------------
-- 1) DO NOT DELETE/ALTER ANY CODE ABOVE THESE INSTRUCTIONS AND DO NOT ADD ANY IMPORTS
-- 2) DO NOT REMOVE / ALTER TYPE DECLERATIONS (I.E THE LINE WITH THE :: ABOUT THE FUNCTION DECLERATION)
--    IF YOU ARE UNABLE TO COMPLETE A FUNCTION, LEAVE IT'S ORIGINAL IMPLEMENTATION (I.E. THROW AN ERROR)
-- 3) MAKE SURE THE PROJECT COMPILES (I.E. RUN STACK BUILD AND MAKE SURE THERE ARE NO ERRORS) BEFORE
--    SUBMITTING, FAILURE TO DO SO WILL RESULT IN A MARK OF 0
-- 4) REPLACE macid = "TODO" WITH YOUR ACTUAL MACID (EX. IF YOUR MACID IS jim THEN macid = "jim")
-----------------------------------------------------------------------------------------------------------

-- Name: Jordan Read
-- Date: Sep 16
macid :: String
macid = "readj11"

(***) :: Double -> Double -> Double
x *** y = if x >= 0 then x ** y else -((-x) ** y)

(===) :: Double -> Double -> Bool
x === y =
  let tol = 1e-3
  in abs (x-y) <= tol

cubeRoot :: Double -> Double
cubeRoot x
  | x < 0     = -((-x) ** (1 / 3))
  | otherwise =     x  ** (1 / 3)

{- -----------------------------------------------------------------
 - cubicQ
 - -----------------------------------------------------------------
 - Description:
 -   Calculates Q of a cubic equation
 -}
cubicQ :: Rational -> Rational -> Rational -> Rational
cubicQ a b c = (3*a*c - b^2) / (9 * a^2)

{- -----------------------------------------------------------------
 - cubicR
 - -----------------------------------------------------------------
 - Description:
 -   Calculates R of a cubic equation
 -}
cubicR :: Rational -> Rational -> Rational -> Rational -> Rational
cubicR a b c d = (9*a*b*c - 27*a^2*d - 2*b^3) / (54*a^3)

{- -----------------------------------------------------------------
 - cubicDiscSign
 - -----------------------------------------------------------------
 - Description:
 -   Calculates the sign of the discriminant (Q^3 + r^2)
 -   Returns 0 if the discriminant is 0
 -}
cubicDiscSign :: Rational -> Rational -> Int
cubicDiscSign q r =
  let disc = q^^3 + r^^2
  in
    if disc < 0
      then -1
      else
        if disc > 0
          then 1
          else 0

{- -----------------------------------------------------------------
 - cubicS
 - -----------------------------------------------------------------
 - Description:
 -   Calculates S of a cubic equation. Returns NaN if the discriminant is less than zero
 -}
cubicS :: Rational -> Rational -> Double
cubicS q r 
  | q^3 + r^2 < 0 = 0/0 -- needed?
  | otherwise     = cubeRoot( dR + sqrt( dQ^3 + dR^2 ) )
  where
    dQ :: Double
    dQ = fromRational(q)
    dR :: Double
    dR = fromRational(r)

{- -----------------------------------------------------------------
 - cubicT
 - -----------------------------------------------------------------
 - Description:
 -   Calculates T of a cubic equation. Returns NaN if the discriminant is less than zero
 -}
cubicT :: Rational -> Rational -> Double
cubicT q r 
  | q^3 + r^2 < 0 = 0/0
  | otherwise     = cubeRoot( dR - sqrt( dQ^3 + dR^2 ) )
  where
    dQ :: Double
    dQ = fromRational(q)
    dR :: Double
    dR = fromRational(r)

{- -----------------------------------------------------------------
 - cubicRealSolutions
 - -----------------------------------------------------------------
 - Description:
 -   Calculates the solutions to a cubic equation.
 -   Returns a list of 0 to 3 rational numbers indicating the solutions.
 -   Does not calculate complex solutions.
 -   Does not calculate real solutions that require complex math.
 -   Returns [] when a == 0, because a == 0 does not represent a cubic equation.
 -}
cubicRealSolutions :: Rational -> Rational -> Rational -> Rational -> [Double]
cubicRealSolutions a b c d
  | a == 0      = []
  | sign == -1  = []
  | sign ==  0  = [x1, x2, x3]
  | sign ==  1  = [x1]
  | otherwise   = []
  where
    sign = cubicDiscSign q r
    s    = cubicS q r
    t    = cubicT q r
    q    = cubicQ a b c
    r    = cubicR a b c d
    x1   = s + t - (fromRational(b) / (3.0*fromRational(a)))
    x2   = -((s + t) / (2.0)) - fromRational(b) / (3.0*fromRational(a))
    x3   = x2

{- -----------------------------------------------------------------
 - Test Cases
 - -----------------------------------------------------------------
 -}

-- TODO: Add Test Cases for each of your functions below here
