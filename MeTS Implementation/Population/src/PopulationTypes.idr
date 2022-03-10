module PopulationTypes

import Mereology
import Provenance
-- Make module accessible to other modules
%access public export


{- Basic Types -}

GeoEntity : Type
GeoEntity = String

Year : Type
Year = Int

Region : Type
Region = List GeoEntity

Interval : Type
Interval = List Year

data PopulationBase = MkP (Region) (Interval)

Population : Type
Population = Expression PopulationBase

data InvalidPopulation = MkIP (Region) (Interval)

{- Mereological Interface Instantiations -}

Mereological GeoEntity where 
    partOf "Scarborough" "Toronto" = True
    partOf "Campbelton (Quebec Part)" "Campbelton" = True
    partOf "Campbelton (NB Part)" "Campbelton" = True
    partOf x y = (x == y)

Mereological Year where
    partOf x y = (x == y)

{- Population Helpers -}

makePop : GeoEntity -> Year -> Population
makePop c y = Atom (MkP [c] [y])

getRegions : List Population -> List Region
getRegions [] = []
getRegions ((Atom (MkP cs _)) :: ps) = [cs] ++ (getRegions ps)
getRegions ((Over _ ps) :: ps') = (getRegions ps) ++ (getRegions ps')

getIntervals : List Population -> List Interval
getIntervals [] = []
getIntervals ((Atom (MkP _ rs)) :: ps) = [rs] ++ (getIntervals ps)
getIntervals ((Over _ ps) :: ps') = (getIntervals ps) ++ (getIntervals ps')

uniquePop : List Population -> List Population