# dynamictest

This package is a first stab at creating an adaptive practice environment for students in introductory statistics (or math) classes, using the *R* package *Shiny*.

This is very much a rudimentary first crack at the moment, but long-term plans for this include:

* A modular environment that allows "plug and play" of question types
  * This is partially implemented at the moment in individual functions (e.g., *meantest.R*) that randomly generate arrays of numbers and ask particular questions.

* Flexible creation of different pre-made or auto-generated question types.

* Adaptive testing based on individuals' "history" of using the practice environment, both within and across sessions.
