module Provenance

import Datatypes

-- Make module accessible to other modules
%access public export


{- Provenance Types -}

data Operation = Sum | Sub | Mult | Div | Avg | Median | Min | Max

data Expression x = Atom x | Over Operation (List (Expression x))

data Derived = Ratio Derived Derived | Product Derived Derived | Base (Expression x) |  Inverse (Expression x)

{- Provenance Interface -}

interface Provenance a where

    {- Precondition helper functions -}
    measured : a -> Bool
    aggregate : a -> Bool
    difference : a -> Bool
    scaled : a -> Bool
    ratio : a -> Bool

{- Precondition Functions -}

allMeasured : Provenance a => List a -> Bool
allMeasured [] = True
allMeasured (x :: xs) = (measured x) && (allMeasured xs)

noMeasured : Provenance a => List a -> Bool
noMeasured [] = True
noMeasured (x :: xs) = (not (measured x)) && (noMeasured xs)

allAggregate : Provenance a => List a -> Bool
allAggregate [] = True
allAggregate (x :: xs) = (aggregate x) && (allAggregate xs)

noAggregate: Provenance a => List a -> Bool
noAggregate [] = True
noAggregate (x :: xs) = (not (aggregate x)) && (noAggregate xs)

allDifference : Provenance a => List a -> Bool
allDifference [] = True
allDifference (x :: xs) = (difference x) && (allDifference xs)

noDifference: Provenance a => List a -> Bool
noDifference [] = True
noDifference (x :: xs) = (not (difference x)) && (noDifference xs)

allScaled : Provenance a => List a -> Bool
allScaled [] = True
allScaled (x :: xs) = (scaled x) && (allScaled xs)

noScaled : Provenance a => List a -> Bool
noScaled [] = True
noScaled (x :: xs) = (not (scaled x)) && (noScaled xs)

allRatio : Provenance a => List a -> Bool
allRatio [] = True
allRatio (x :: xs) = (ratio x) && (allRatio xs)

noRatio : Provenance a => List a -> Bool
noRatio [] = True
noRatio (x :: xs) = (not (ratio x)) && (noRatio xs)

allSameKind : Provenance a => List a -> Bool
allSameKind xs = (allMeasured xs) || (allAggregate xs) || (allDifference xs) || (allScaled xs) || (allRatio xs)

{- Derived Types -}

{- General Preconditions -}

{- Provenance Verification functions -}

mult : Provenance a => a -> a -> a

div : Provenance a => a -> a -> a

{- Expression Functions -}


