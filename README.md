# Meaningful Type Safety For Data Science
This repository contains the Idris source code to accompany the paper "What’s in a (Data) Type? Meaningful Type Safety in Data Science".

## Contents

Mereology, Provenance, PopulationTypes, PopulationProvenance, Census, & Main idris source files.

### Mereology
Mereology.idr defines the mereological interface, types that implement the 'partOf' and disjoint relations. Disjoint is defined in terms of partOf, if the part of relation holds in either direction, than those individuals are not disjoint. It also contains functions for applying mereological relations to lists and lists of lists.

### Provenance
Provenance.idr defines the primary mechanism of type-checking provenance, expression trees. It contains the definition of operations, expressions, as well as convenience functions for type-checking expression trees, defined in the provenance interface. 

### PopulationTypes

### PopulationProvenance

### Census

### Main


