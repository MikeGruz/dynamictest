# dynamictest

Must have the `Shiny` package installed in R.  

```
shiny::runGitHub('dynamictest','MikeGruz')
```

Construct a url with the methods listed in a URI, as such (method names must match method names in the `/tests` folder):

```
http://{base url of app}/?method=regress,ttest
```

This package is a first stab at creating an adaptive practice environment for students in introductory statistics (or math) classes, using the *R* package *Shiny*.

This includes:  

* A modular environment that allows "plug and play" of question types
  * This is implemented at the moment in individual functions (e.g., *meantest.R*) that randomly generate arrays of numbers and ask particular questions.
  * Question types available include verbatim numeric and text input, as well as multiple choice.

* Flexible creation of different pre-made or auto-generated question types.

To be implemented:  

* Adaptive testing based on individuals' "history" of using the practice environment, both within and across sessions.

* Registration and authentication options for users.
