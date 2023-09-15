# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

module MINLPTests

using JuMP
using Test

###
### Default tolerances that are used in the tests.
###

# Absolute tolerance when checking the objective value.
const OPT_TOL = 1e-6

# Absolute tolerance when checking the primal solution value.
const PRIMAL_TOL = 1e-6

# Absolue tolerance when checking the dual solution value.
const DUAL_TOL = 1e-6

###
### Default expected status codes for different types of problems and solvers.
###

# We only distinguish between feasible and infeasible problems now.
@enum ProblemTypeCode FEASIBLE_PROBLEM INFEASIBLE_PROBLEM

# Target status codes for local solvers:
const TERMINATION_TARGET_LOCAL = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.LOCALLY_SOLVED,
    INFEASIBLE_PROBLEM => JuMP.MOI.LOCALLY_INFEASIBLE,
)
const PRIMAL_TARGET_LOCAL = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.FEASIBLE_POINT,
    INFEASIBLE_PROBLEM => JuMP.MOI.INFEASIBLE_POINT,
)

# Target status codes for global solvers:
const TERMINATION_TARGET_GLOBAL = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.OPTIMAL,
    INFEASIBLE_PROBLEM => JuMP.MOI.INFEASIBLE,
)
const PRIMAL_TARGET_GLOBAL = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.FEASIBLE_POINT,
    INFEASIBLE_PROBLEM => JuMP.MOI.NO_SOLUTION,
)

###
### Helper functions for the tests.
###

function check_status(
    model,
    problem_type::ProblemTypeCode,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    @test JuMP.termination_status(model) == termination_target[problem_type]
    @test JuMP.primal_status(model) == primal_target[problem_type]
end

function check_objective(model, solution; tol = OPT_TOL)
    if !isnan(tol)
        @test isapprox(JuMP.objective_value(model), solution, atol = tol)
    end
end

function check_solution(variables, solutions; tol = PRIMAL_TOL)
    if !isnan(tol)
        @assert length(variables) == length(solutions)
        for (variable, solution) in zip(variables, solutions)
            @test isapprox(JuMP.value(variable), solution, atol = tol)
        end
    end
end

function check_dual(constraints, solutions; tol = DUAL_TOL)
    if !isnan(tol)
        @assert length(constraints) == length(solutions)
        for (constraint, solution) in zip(constraints, solutions)
            @test isapprox(JuMP.dual(constraint), solution, atol = tol)
        end
    end
end

###
### Loop through and include every model function.
###

for directory in
    ["nlp", "nlp-cvx", "nlp-mi", "nlp-expr", "nlp-cvx-expr", "nlp-mi-expr"]
    files = readdir(joinpath(@__DIR__, directory))
    for file_name in filter(f -> endswith(f, ".jl"), files)
        include(joinpath(@__DIR__, directory, file_name))
    end
end

"""
    test_directory(
        directory,
        optimizer;
        debug::Bool = false,
        exclude = String[],
        include = String[],
        objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL,
        dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL,
    )

Test all of the files in `directory` using `optimizer`.

If `debug`, print the name of the file befor running it.

Use `exclude` and `include` to run a subset of the files in a directory.

Use the remaining args to control tolerances and status targets.

## Example

Test all but nlp_001_010:
```julia
test_directory("nlp", optimizer; exclude = ["001_010"])
```

Test only nlp_001_010:
```julia
test_directory("nlp", optimizer; include = ["001_010"])
```
"""
function test_directory(
    directory,
    optimizer;
    debug::Bool = false,
    exclude = String[],
    include = String[],
    objective_tol = OPT_TOL,
    primal_tol = PRIMAL_TOL,
    dual_tol = DUAL_TOL,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    @testset "$(directory)" begin
        models = _list_of_models(directory, exclude, include)
        @testset "$(model_name)" for model_name in models
            if debug
                println("Running $(model_name)")
            end
            getfield(MINLPTests, model_name)(
                optimizer,
                objective_tol,
                primal_tol,
                dual_tol,
                termination_target,
                primal_target,
            )
        end
    end
end

function _list_of_models(
    directory,
    exclude::Vector{String},
    include::Vector{String},
)
    dir = replace(directory, "-" => "_")
    if length(include) > 0
        return [Symbol("$(dir)_$(i)") for i in include]
    else
        models = Symbol[]
        for file in readdir(joinpath(@__DIR__, directory))
            if !endswith(file, ".jl")
                continue
            end
            file = replace(file, ".jl" => "")
            if file in exclude
                continue
            end
            push!(models, Symbol("$(dir)_$(file)"))
        end
        return models
    end
end

###
### Helper functions to test a subset of models.
###

for (f, str) in [
    :test_nlp => "nlp",
    :test_nlp_cvx => "nlp-cvx",
    :test_nlp_mi => "nlp-mi",
    :test_nlp_expr => "nlp-expr",
    :test_nlp_cvx_expr => "nlp-cvx-expr",
    :test_nlp_mi_expr => "nlp-mi-expr",
]
    @eval function $f(
        optimizer;
        debug::Bool = false,
        exclude = String[],
        objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL,
        dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL,
    )
        return test_directory(
            $str,
            optimizer;
            debug = debug,
            exclude = exclude,
            objective_tol = objective_tol,
            primal_tol = primal_tol,
            dual_tol = dual_tol,
            termination_target = termination_target,
            primal_target = primal_target,
        )
    end
end

### Tests that haven't been updated.

include("nlp-mi-cvx/tests.jl")
include("poly/tests.jl")
include("poly-cvx/tests.jl")
include("poly-mi/tests.jl")
include("poly-mi-cvx/tests.jl")

end
