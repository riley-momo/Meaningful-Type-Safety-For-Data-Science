# Meaningful Type Safety For Data Science
This repository contains the Idris source code to accompany the paper "What’s in a (Data) Type? Meaningful Type Safety in Data Science".

## Contents

Mereology, Provenance, PopulationTypes, PopulationProvenance, Census, & Main idris source files.

### Mereology
Mereology.idr defines the mereological interface, types that implement the 'partOf' and disjoint relations. Disjoint is defined in terms of partOf, if the part of relation holds in either direction, than those individuals are not disjoint. It also contains functions for applying mereological relations to lists and lists of lists.

### Provenance
Provenance.idr defines the primary mechanism of type-checking provenance, expression trees. It contains the definition of operations, expressions, as well as convenience functions for type-checking expression trees, defined in the provenance interface. 

### PopulationTypes
PopulationTypes.idr defines the basic types for population concepts modelled within the motivating StatCAN dataset, including geographic entities, years, regions, time intervals, and populations. It also defines the instantations of the mereological interface for these types in order to assist type-checking and define disjointness specifically for these types.

### PopulationProvenance
PopulationProvenance.idr contains the instantations of the provenance interface for the types contained within PopulationTypes. This is also where population preconditions are defined. The general strucure of this file is the most significant technically, and it represents the general structure of MeTS type-checking functions.

### Census
Census.idr instantiates concepts contained within specific rows of the motivating data to be compatible with MeTS type-checking. In future development, this file would be automatically created from the source dataset.

### Main
Main.idr is equivalent to the commands that the end-user data scientist would perform, and this is where type-checking actually occurs. It contains 9 different operations, the last 6 of which do not sucesfully type check as they are examples of datatype errors including ones of mereology, time, and provenance.


