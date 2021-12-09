module Census

import Mereology
import Provenance
import PopulationTypes
import PopulationProvenance

-- Make module accessible to other modules
%access public export

twentyeleven : Year
twentyeleven = 2011

twentysixteen : Year
twentysixteen = 2016

toronto : GeoEntity
toronto = "Toronto"

hamilton : GeoEntity
hamilton = "Hamilton"

guelph : GeoEntity 
guelph = "Guelph"

scarborough : GeoEntity
scarborough = "Scarborough"

campbelton : GeoEntity
campbelton = "Campbelton"

campbeltonNB : GeoEntity
campbeltonNB = "Campbelton (NB Part)"

campbeltonQ : GeoEntity
campbeltonQ = "Campbelton (Quebec Part)"

toronto2011 : Population
toronto2011 = makePop toronto 2011

hamilton2011 : Population
hamilton2011 = makePop hamilton 2011

guelph2011 : Population
guelph2011 = makePop guelph 2011

guelph2016 : Population
guelph2016 = makePop guelph 2016

scarborough2011 : Population
scarborough2011 = makePop scarborough 2011

campbelton2011 : Population
campbelton2011 = makePop campbelton 2011

campbeltonQ2011 : Population
campbeltonQ2011 = makePop campbeltonQ 2011

campbeltonNB2011 : Population
campbeltonNB2011 = makePop campbeltonNB 2011