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
### Helper functions for the tests.
###

# Additional termination status codes that are also accepted (incomplete).
const EXTRA_TERMINATION = Dict(
    JuMP.MOI.ALMOST_LOCALLY_SOLVED => (
        JuMP.MOI.LOCALLY_SOLVED,
        JuMP.MOI.OPTIMAL,
    ),
    JuMP.MOI.ALMOST_OPTIMAL => (
        JuMP.MOI.OPTIMAL,
    ),
    JuMP.MOI.LOCALLY_SOLVED => (
        JuMP.MOI.OPTIMAL,
    ),
    JuMP.MOI.LOCALLY_INFEASIBLE => (
        JuMP.MOI.INFEASIBLE,
    ),
)

# Additional result status codes that are also accepted (incomplete).
const EXTRA_RESULT = Dict(
    JuMP.MOI.NEARLY_FEASIBLE_POINT => (
        JuMP.MOI.FEASIBLE_POINT,
    ),
)

function check_status(status::JuMP.MOI.TerminationStatusCode,
                      target::JuMP.MOI.TerminationStatusCode)
    return status == target || status in get(EXTRA_TERMINATION, target, ())
end

function check_status(status::JuMP.MOI.ResultStatusCode,
                      target::JuMP.MOI.ResultStatusCode)
    return status == target || status in get(EXTRA_RESULT, target, ())
end

function check_status(model, termination_target, primal_target)
    @test check_status(JuMP.termination_status(model), termination_target)
    @test check_status(JuMP.primal_status(model), primal_target)
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
        objective_tol = OPT_TOL, primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL)
    @testset "$(directory)" begin
        @testset "$(model_name)" for model_name in list_of_models(directory, exclude, include)
            function_name = string(replace(directory, "-" => "_"), "_", model_name)
            model_function = getfield(MINLPTests, Symbol(function_name))
            model_function(optimizer, objective_tol, primal_tol, dual_tol)
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
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL)
    test_directory("nlp", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol)
end

function test_nlp_cvx(
        optimizer; exclude = String[], objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL)
    test_directory("nlp-cvx", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol)
end

function test_nlp_mi(
        optimizer; exclude = String[], objective_tol = OPT_TOL,
        primal_tol = PRIMAL_TOL, dual_tol = DUAL_TOL)
    test_directory("nlp-mi", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol)
end

### Tests that haven't been updated.

include("nlp-mi-cvx/tests.jl")
include("poly/tests.jl")
include("poly-cvx/tests.jl")
include("poly-mi/tests.jl")
include("poly-mi-cvx/tests.jl")

end
