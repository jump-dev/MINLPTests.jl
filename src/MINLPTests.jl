module MINLPTests

using JuMP, Test

###
### Helper functions for the tests.
###

function check_status(status; target = :Optimal)
    @test status == target
end

function check_objective(model, val; tol = 1e-7)
    @test isapprox(getobjectivevalue(model), val, atol = tol)
end

function check_solution(vars, vals; tol = 1e-7)
    @assert length(vars) == length(vals)
    for (var, val) in zip(vars, vals)
        @test isapprox(getvalue(var), val, atol = tol)
    end
end

function check_dual(cons, vals; tol = 1e-7)
    @assert length(cons) == length(vals)
    for (con, val) in zip(cons, vals)
        @test isapprox(getdual(con), val, atol = tol)
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
        objective_tol = 1e-7, primal_tol = 1e-7, dual_tol = 1e-7)
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
        optimizer; exclude = String[], objective_tol = 1e-7,
        primal_tol = 1e-7, dual_tol = 1e-7)
    test_directory("nlp", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol)
end

function test_nlp_cvx(
        optimizer; exclude = String[], objective_tol = 1e-7,
        primal_tol = 1e-7, dual_tol = 1e-7)
    test_directory("nlp-cvx", optimizer;
        exclude = exclude, objective_tol = objective_tol,
        primal_tol = primal_tol, dual_tol = dual_tol)
end

function test_nlp_mi(
        optimizer; exclude = String[], objective_tol = 1e-7,
        primal_tol = 1e-7, dual_tol = 1e-7)
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
