# MINLPTests.jl
This is a collection of JuMP models for testing nonlinear/polynomial solvers with and without discrete variables in JuMP.


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
