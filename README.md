# MINLPTests.jl

**master:** [![Build Status](https://travis-ci.org/JuliaOpt/MINLPTests.jl.svg?branch=master)](https://travis-ci.org/JuliaOpt/MINLPTests.jl)

**moi:** [![Build Status](https://travis-ci.org/JuliaOpt/MINLPTests.jl.svg?branch=od%2Fmoi)](https://travis-ci.org/JuliaOpt/MINLPTests.jl)

This is a collection of JuMP models for testing nonlinear/polynomial solvers with and without discrete variables in JuMP.

The `master` branch is compatible with the current release of JuMP (using MathProgBase).  A forthcoming `moi` branch will be used for testing the next release of JuMP.


## Test Design Guidelines

* Tests are into broad categories based on the scope of typical solvers (e.g. continuous, convex functions, polynomial, ...)
* Unit tests should be "easy" models, it should be possible for a non-global solver to find the global solution
* Mathematical property tests can be more difficult


## Test Naming Conventions

Directories:
* nlp - nonconvex NLP models
* nlp-cvx - convex NLP models
* nlp-mi - nonconvex MINLP models
* nlp-mi-cvx - convex MINLP models
* poly - nonconvex polynomial models
* poly-cvx - convex polynomial models
* poly-mi - nonconvex polynomial models
* poly-mi-cvx - convex polynomial models

File Names:
* 0xx_yyz - unit tests
* 1xx_yyz - 2D mathematical properties
* 2xx_yyz - 3D mathematical properties
* 5xx_yyz - nD mathematical properties
* 9xx_yyz - integration tests

z indicates a variant of a base problem

## Test Coverage Overview

### NLP
* non-linear model without stating values (nlp/003_010)
* non-linear model with stating values (nlp/002_010)
* non-linear model partial stating values (nlp/001_010)

* non-linear objective only (nlp/001_010)
* non-linear constraints only (nlp/002_010)
* non-linear objective and constraints (nlp/003_010)

* non-linear objective + linear constraints (nlp/004_010)
* non-linear objective + linear constraints (as NL) (nlp/004_011)
* non-linear objective + quard constraints (nlp/004_010)
* non-linear objective + quard constraints (as NL) (nlp/004_011)

* minimization objective (nlp/001_010)
* maximization objective (nlp/003_010)

* linear objective + non-linear constraints (nlp/003_012)
* linear objective (as NL) + non-linear constraints (nlp/003_013)
* quad objective + non-linear constraints (nlp/003_014)
* quad objective (as NL) + non-linear constraints (nlp/003_015)

* non-linear objective (with offset const) + non-linear constraints (nlp/003_011)
* objective (with offset const) + non-linear constraints (nlp/003_016)

* status infeasible (nlp/007_010)
* get duals (nlp/008_010, 008_011)

* non-linear functions
  * \* (nlp/004_010)
  * / (nlp/005_010)
  * \ (nlp/005_011)
  * ^ (nlp/001_010)
  * sqrt (nlp/003_010)
  * abs (nlp/004_010)
  * exp (nlp/001_010)
  * log (nlp/002_010)
  * sin (nlp/003_010)
  * cos (nlp/001_010)
  * tan (nlp/004_010)
  * user defined (nlp/006_010)

### MINLP
* non-linear integer variable (nlp-mi/001_010)
* non-linear binary variable (nlp-mi/002_010)
* mix of continuous and discrete variables (nlp-mi/001_010)
* non-linear model without stating values (nlp-mi/003_010)
* non-linear model with stating values (nlp-mi/002_010)
* non-linear model partial stating values (nlp-mi/001_010)

* non-linear objective only (nlp-mi/001_010)
* non-linear constraints only (nlp-mi/002_010)
* non-linear objective and constraints (nlp-mi/003_010)

* non-linear objective + linear constraints (nlp-mi/004_010)
* non-linear objective + linear constraints (as NL) (nlp-mi/004_011)
* non-linear objective + quard constraints (nlp-mi/004_010)
* non-linear objective + quard constraints (as NL) (nlp-mi/004_011)

* minimization objective (nlp-mi/001_010)
* maximization objective (nlp-mi/003_010)

* linear objective + non-linear constraints (nlp-mi/003_012)
* linear objective (as NL) + non-linear constraints (nlp-mi/003_013)
* quad objective + non-linear constraints (nlp-mi/003_014)
* quad objective (as NL) + non-linear constraints (nlp-mi/003_015)

* non-linear objective (with offset const) + non-linear constraints (nlp-mi/003_011)
* objective (with offset const) + non-linear constraints (nlp-mi/003_016)

* status infeasible (nlp-mi/007_010, nlp-mi/070_020)

* non-linear functions
  * \* (nlp-mi/004_010)
  * / (nlp-mi/005_010)
  * \ (nlp-mi/005_011)
  * ^ (nlp-mi/001_010)
  * sqrt (nlp-mi/003_010)
  * abs (nlp-mi/004_010)
  * exp (nlp-mi/001_010)
  * log (nlp-mi/002_010)
  * sin (nlp-mi/003_010)
  * cos (nlp-mi/001_010)
  * tan (nlp-mi/004_010)
  * user defined (nlp-mi/006_010)

### Untested Julia Functions
A complete list is available [here](https://docs.julialang.org/en/v1/base/math/)

* roots
  * cbrt
  * hypot
* exponentials
  * log2
  * log10
  * exp2
  * exp10
* transcendentals
  * sincos
  * sind, cosd, tand
  * sinh, cosh, tanh
  * asin, acos, atan (x and x,y)
  * sec, csc, cot
  * asec, acsc, acot
  * sech, csch, coth
  * asinh, acosh, atanh
  * asech, acsch, acoth
* discontinuous
  * rem
  * mod
  * ceil
  * floor
  * min
  * max
