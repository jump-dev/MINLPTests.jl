# MINLPTests.jl
This is a collection of JuMP models for testing nonlinear/polynomial solvers with and without discrete variables in JuMP.


## Test Design Guidelines

* Unit tests should be "easy" models, it should be possible for a non-global solver to find the global solution
* Mathmatical property tests can be more difficult


## Test Naming Conventions

Directories:
* nlp - nonconvex NLP models
* nlp-cvx - convex NLP models
* minlp - nonconvex MINLP models
* minlp-cvx - convex MINLP models
* poly - nonconvex polynomial models
* poly-cvx - convex polynomial models
* mipoly - nonconvex polynomial models
* mipoly-cvx - convex polynomial models

File Names:
* 0xx_yyz - unit tests
* 1xx_yyz - 2D mathematical properties
* 2xx_yyz - 3D mathematical properties
* 5xx_yyz - nD mathematical properties
* 9xx_yyz - integration tests

z indicates a variant of a base problem
