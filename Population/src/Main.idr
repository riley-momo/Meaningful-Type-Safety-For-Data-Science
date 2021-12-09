module Main

import Mereology
import Provenance
import PopulationTypes
import PopulationProvenance
import Census



op1 : Population
op1 = popSum ([toronto2011, hamilton2011] ** Refl)

op2 : Population
op2 = popSum ([op1, guelph2011] ** Refl)

op3 : Population
op3 = popSum ([scarborough2011, guelph2011] ** Refl)

{- Should not type check -}
op4 : Population
op4 = (popSum ([toronto2011, scarborough2011, hamilton2011] ** Refl))

{- Should not type check -}
op5 : Population
op5 = popMedian ([toronto2011, hamilton2011, campbelton2011, campbeltonNB2011, campbeltonQ2011, guelph2011] ** Refl)

{- Should not type check -}
op6 : Population
op6 = popAvg ([popAvg ([toronto2011, hamilton2011] ** Refl), popAvg ([guelph2011, campbelton2011] ** Refl)] ** Refl)

{- Should not type check -}
op7 : Population
op7 = popSum ([popAvg ([toronto2011, hamilton2011] ** Refl), guelph2011] ** Refl)

{- Should not type check -}
op8 : Population
op8 = popSum ([toronto2011, guelph2016, hamilton2011] ** Refl)

{- Should not type check -}
op9 : Population
op9 = popAvg ([popSub ((toronto2011, hamilton2011) ** Refl), popSub ((guelph2016, guelph2011) ** Refl)] ** Refl)