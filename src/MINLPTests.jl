module MINLPTests

using JuMP, Test

###
### Default tolerances that are used in the tests.
###

# Absolute tolerance when checking the objective value.
const OPT_TOL    = 1e-6

# Absolute tolerance when checking the primal solution value.
const PRIMAL_TOL = 1e-6

# Absolue tolerance when checking the dual solution value.
const DUAL_TOL   = 1e-6

###
### Default expected status codes for different types of problems.
###

# We only distinguish between feasible and infeasible problems now.
@enum ProblemTypeCode FEASIBLE_PROBLEM INFEASIBLE_PROBLEM

TERMINATION_TARGET = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.LOCALLY_SOLVED,
    INFEASIBLE_PROBLEM => JuMP.MOI.LOCALLY_INFEASIBLE,
)

PRIMAL_TARGET = Dict(
    FEASIBLE_PROBLEM => JuMP.MOI.FEASIBLE_POINT,
    INFEASIBLE_PROBLEM => JuMP.MOI.INFEASIBLE_POINT,
)

###
### Helper functions for the tests.
###

function check_status(model, problem_type::ProblemTypeCode,
                      termination_target=TERMINATION_TARGET,
                      primal_target=PRIMAL_TARGET)
    @test JuMP.termination_status(model) == TERMINATION_TARGET[problem_type]
    @test JuMP.primal_status(model) == PRIMAL_TARGET[problem_type]
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

for directory in ["nlp", "nlp-cvx", "nlp-mi"]
    for file_name in filter(f -> endswith(f, ".jl"), readdir(joinpath(@__DIR__, directory)))
        include(joinpath(@__DIR__, directory, file_name))
    end
end

"""
    test_directory(directory, optimizer; exclude=String[], include=String[])

### Example

    optimizer = JuMP.with_optimizer(Ipopt.Optimizer)
    # Test all but nlp_001_010.
    test_directory("nlp", optimizer; exclude = ["001_010"])
    # Test only nlp_001_010.
    test_directory("nlp", optimizer; include = ["001_010"])
"""
function test_directory(
        directory, optimizer; exclude=String[], include=String[],
        objective_tol = OPT_TOL, primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)

    @testset "$(directory)" begin
        @testset "$(model_name)" for model_name in list_of_models(directory, exclude, include)
            function_name = string(replace(directory, "-" => "_"), "_", model_name)
            model_function = getfield(MINLPTests, Symbol(function_name))
            model_function(optimizer, objective_tol, primal_tol, dual_tol,
                           termination_target, primal_target)
        end
    end
end

function list_of_models(directory, exclude::Vector{String}, include::Vector{String})
    if length(include) > 0
        return include
    else
        models = String[]
        for file in readdir(joinpath(@__DIR__, directory))
            !endswith(file, ".jl") && continue
            file = replace(file, ".jl" => "")
            file in exclude && continue
            push!(models, file)
        end
        return models
    end
end

###
### Helper functions to test a subset of models.
###

function test_nlp(
        optimizer; exclude = String[], objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    test_directory("nlp", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol,
        termination_target = termination_target,
        primal_target = primal_target)
end

function test_nlp_cvx(
        optimizer; exclude = String[], objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    test_directory("nlp-cvx", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol,
        termination_target = termination_target,
        primal_target = primal_target)
end

function test_nlp_mi(
        optimizer; exclude = String[], objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    test_directory("nlp-mi", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol,
        termination_target = termination_target,
        primal_target = primal_target)
end

### Tests that haven't been updated.

include("nlp-mi-cvx/tests.jl")
include("poly/tests.jl")
include("poly-cvx/tests.jl")
include("poly-mi/tests.jl")
include("poly-mi-cvx/tests.jl")

end
