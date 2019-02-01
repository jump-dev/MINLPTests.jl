OPT_TOL = 1e-7
SOL_TOL = 1e-7
DUAL_TOL = 1e-7

function check_status(model; termination_targe=JuMP.MOI.LOCALLY_SOLVED, primal_target=JuMP.MOI.FEASIBLE_POINT)
    @test JuMP.termination_status(model) == termination_targe
    @test JuMP.primal_status(model) == primal_target
end

function check_objective(model, val)
    @test isapprox(JuMP.objective_value(model), val, atol=OPT_TOL)
end

function check_solution(vars, vals)
    @assert length(vars) == length(vals)
    for (var, val) in zip(vars, vals)
        @test isapprox(JuMP.value(var), val, atol=SOL_TOL)
    end
end

function check_dual(cons, vals)
    @assert length(cons) == length(vals)
    for (con, val) in zip(cons, vals)
        @test isapprox(JuMP.dual(con), val, atol=DUAL_TOL)
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
function test_directory(directory, optimizer; exclude=String[], include=String[])
    @testset "$(directory)" begin
        @testset "$(model_name)" for model_name in list_of_models(directory, exclude, include)
            function_name = string(replace(directory, "-" => "_"), "_", model_name)
            model_function = getfield(MINLPTests, Symbol(function_name))
            model_function(optimizer)
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

function test_nlp(optimizer)
    test_directory("nlp", optimizer; exclude = [
        "005_011",  # "Unrecognized function "\" used in nonlinear expression."
        "008_011",  # MethodError: no method matching getdual.
    ])
end

function test_nlp_cvx(optimizer)
    test_directory("nlp-cvx", optimizer)
end


###
### These helper functions were used to conver the file-based tests that existed
### pre-MathOptInterface into a function-based testing system.
###

function convert_file(file_name)
    file = split(String(read(file_name)), "\n")

    path_items = split(file_name, "/")
    model_name = path_items[end]
    directory = path_items[end-1]

    function_name = string(
        replace(directory, "-" => "_"),
        "_",
        replace(model_name, ".jl" => "")
    )
    open(file_name, "w") do io
        write(io, "function $(function_name)(optimizer)\n")
        for line in file
            write(io, "    ", line, "\n")
        end
        write(io, "end\n")
    end
end

function convert_directory(directory)
    for file_name in filter(f -> endswith(f, ".jl"), readdir(directory))
        convert_file(joinpath(directory, file_name))
    end
end
