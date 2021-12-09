module Mereology

-- Make module accessible to other modules
%access public export

{- Interfaces -}

interface Mereological a where
    partOf : a -> a -> Bool
    disjoint : a -> a -> Bool

    disjoint x y = not (partOf x y || partOf y x)

interface Overlappable a where
    overlaps : a -> a -> Bool

{- Basic Mereological List Functions -}

partOfElem : Mereological a => a -> List a -> Bool
partOfElem x [] = False
partOfElem x (y :: ys) = (partOf x y) || (partOfElem x ys)

disjointFromList : Mereological a => a -> List a -> Bool
disjointFromList x [] = True
disjointFromList x (y :: ys) = (disjoint x y) && (disjointFromList x ys)

disjointList : Mereological a => List a -> Bool
disjointList [] = True
disjointList (x1 :: xs) = (disjointFromList x1 xs) && (disjointList xs)

disjointLists : Mereological a => List a -> List a -> Bool
disjointLists [] [] = True
disjointLists _ [] = True
disjointLists [] _ = True
disjointLists l1@(x :: xs) l2@(y :: ys) = (disjointList l1) && (disjointList l2) && (disjointFromList x l2) && (disjointFromList y l1) && (disjointLists xs ys)

disjointLol : Mereological a => List (List a) -> Bool
disjointLol [] = True
disjointLol (l1 :: ls) = (all (==True) [disjointLists l1 l | l <- ls]) && (disjointLol ls)

{- General List Helper Functions -}

sameElements : Eq a => List a -> List a -> Bool
sameElements [] [] = True
sameElements _ [] = False
sameElements [] _ = False
sameElements l1@(x :: xs) l2@(y :: ys) = (elem x l2) && (elem y l1) && (sameElements xs ys) 

noCommonElements : Eq a => List a -> List a -> Bool
noCommonElements _ [] = True
noCommonElements [] _ = True
noCommonElements l1@(x :: xs) l2@(y :: ys) = (not (elem x l2)) && (not (elem y l1)) && (noCommonElements xs ys)

overlappingList : Eq a => List a -> Bool
overlappingList [] = False
overlappingList (x :: xs) = (elem x xs) || (overlappingList xs)

sameElementsLol : Eq a => List (List a) -> Bool
sameElementsLol [] = True
sameElementsLol [l] = True
sameElementsLol (l1 :: ls) = (all (==True) [sameElements l1 l | l <- ls])

noCommonElementsLol : Eq a => List (List a) -> Bool
noCommonElementsLol [] = True
noCommonElementsLol [l] = True
noCommonElementsLol (l1 :: ls) = (all (==True) [noCommonElements l1 l | l <- ls]) && (noCommonElementsLol ls)

