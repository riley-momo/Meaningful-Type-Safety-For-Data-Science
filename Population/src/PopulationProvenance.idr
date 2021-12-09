module PopulationProvenance

import Mereology
import Provenance
import PopulationTypes

-- Make module accessible to other modules
%access public export


{- Instances of Provenance interfaces -}

Provenance Population where 
    measured (Atom p) = True
    measured (Over Max ps) = (allMeasured ps)
    measured (Over Sum ps) = True
    measured _ = False

    aggregate (Over Avg ps) = True
    aggregate (Over Median ps) = True
    aggregate _ = False

    difference (Over Sub ps) = True
    difference _ = False

    scaled (Over Mult ps) = True 
    scaled _ = False

    ratio (Over Div ps) = True
    ratio _ = False

{- Population Provenance functions -}

measuredPop : Population -> Bool
measuredPop (Atom p) = True
measuredPop (Over Max ps) = True
measuredPop (Over Sum ps) = True
measuredPop _ = False

aggregatePop : Population -> Bool
aggregatePop (Over Avg ps) = True
aggregatePop (Over Median ps) = True
aggregatePop _ = False

differencePop : Population -> Bool
differencePop (Over Sub ps) = True
differencePop _ = False

scaledPop : Population -> Bool
scaledPop (Over Mult ps) = True 
scaledPop _ = False

ratioPop : Population -> Bool
ratioPop (Over Div ps) = True
ratioPop _ = False

{- Population List Provenance Functions -}

allMeasuredPop : List Population -> Bool
allMeasuredPop [] = True
allMeasuredPop (x :: xs) = (measuredPop x) && (allMeasuredPop xs)

noMeasuredPop : List Population -> Bool
noMeasuredPop [] = True
noMeasuredPop (x :: xs) = (not (measuredPop x)) && (noMeasuredPop xs)

allAggregatePop : List Population -> Bool
allAggregatePop [] = True
allAggregatePop (x :: xs) = (aggregatePop x) && (allAggregatePop xs)

noAggregatePop: List Population -> Bool
noAggregatePop [] = True
noAggregatePop (x :: xs) = (not (aggregatePop x)) && (noAggregatePop xs)

allDifferencePop : List Population -> Bool
allDifferencePop [] = True
allDifferencePop (x :: xs) = (differencePop x) && (allDifferencePop xs)

noDifferencePop: List Population -> Bool
noDifferencePop [] = True
noDifferencePop (x :: xs) = (not (differencePop x)) && (noDifferencePop xs)

allScaledPop : List Population -> Bool
allScaledPop [] = True
allScaledPop (x :: xs) = (scaledPop x) && (allScaledPop xs)

noScaledPop : List Population -> Bool
noScaledPop [] = True
noScaledPop (x :: xs) = (not (scaledPop x)) && (noScaledPop xs)

allRatioPop : List Population -> Bool
allRatioPop [] = True
allRatioPop (x :: xs) = (ratioPop x) && (allRatioPop xs)

noRatioPop : List Population -> Bool
noRatioPop [] = True
noRatioPop (x :: xs) = (not (ratioPop x)) && (noRatioPop xs)

allSameKindPop : List Population -> Bool
allSameKindPop xs = (allMeasuredPop xs) || (allAggregatePop xs) || (allDifferencePop xs) || (allScaledPop xs) || (allRatioPop xs)


{- Precondition Definitions -}

disjointRegions : (List Population) -> Bool
disjointRegions ps = disjointLol (getRegions ps)

differingYears : (List Population) -> Bool
differingYears ps = disjointLol (getIntervals ps)

allSameYears : List Population -> Bool
allSameYears ps = sameElementsLol (getIntervals ps)

allSameRegions : List Population -> Bool
allSameRegions ps = sameElementsLol (getRegions ps)

differOverOne : List Population -> Bool
differOverOne ps = ((allSameRegions ps) && (differingYears ps)) || ((allSameYears ps) && (disjointRegions ps))

{- Operation preconditions -}

sumPreconditions : List Population -> Bool
sumPreconditions ps = ((disjointRegions ps) && (allSameYears ps) && (allMeasuredPop ps))

subPreconditions : (Population, Population) -> Bool
subPreconditions ps = ((differOverOne ((Prelude.Basics.fst ps) :: [(Prelude.Basics.snd ps)])) && (allSameKindPop ((Prelude.Basics.fst ps) :: [(Prelude.Basics.snd ps)])))

divPreconditions : (Population, Population) -> Bool
divPreconditions ps = (differOverOne ((Prelude.Basics.fst ps) :: [(Prelude.Basics.snd ps)]))

multPreconditions : (Population, Population) -> Bool
multPreconditions ps = False

avgPreconditions : List Population -> Bool
avgPreconditions ps = (differOverOne ps) && (allSameKindPop ps) && (noAggregatePop ps)

medianPreconditions : List Population -> Bool
medianPreconditions ps = (differOverOne ps) && (allMeasuredPop ps)

minMaxPreconditions : List Population -> Bool
minMaxPreconditions ps = (differOverOne ps) && (allSameKindPop ps)


{- Population Computation Type Signatures -}

popSum : (ps : List Population ** ((sumPreconditions ps) = True)) -> Population
popSum (ps ** preconditionsHold) =  Over Sum ps

popSub : (ps : (Population, Population) ** (subPreconditions ps = True)) -> Population
popSub (ps ** preconditionsHold) =  Over Sum ((Prelude.Basics.fst ps) :: [(Prelude.Basics.snd ps)])

popDiv : (ps : (Population, Population) ** (divPreconditions ps = True)) -> Population
popDiv (ps ** preconditionsHold) = Over Div ((Prelude.Basics.fst ps) :: [(Prelude.Basics.snd ps)])

popAvg : (ps : List Population ** (avgPreconditions ps = True)) -> Population
popAvg (ps ** preconditionsHold) =  Over Avg ps

popMedian : (ps : List Population ** (medianPreconditions ps = True)) -> Population
popMedian (ps ** preconditionsHold) =  Over Median ps

popMin : (ps : List Population ** (minMaxPreconditions ps = True)) -> Population
popMin (ps ** preconditionsHold) =  Over Min ps

popMax : (ps : List Population ** (minMaxPreconditions ps = True)) -> Population
popMax (ps ** preconditionsHold) =  Over Max ps