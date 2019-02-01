function check_status(
        model;
        termination_target = JuMP.MOI.LOCALLY_SOLVED,
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    @test JuMP.termination_status(model) == termination_target
    @test JuMP.primal_status(model) == primal_target
end

function check_objective(model, val; tol = 1e-7)
    @test isapprox(JuMP.objective_value(model), val, atol = tol)
end

function check_solution(vars, vals; tol = 1e-7)
    @assert length(vars) == length(vals)
    for (var, val) in zip(vars, vals)
        @test isapprox(JuMP.value(var), val, atol = tol)
    end
end

function check_dual(cons, vals; tol = 1e-7)
    @assert length(cons) == length(vals)
    for (con, val) in zip(cons, vals)
        @test isapprox(JuMP.dual(con), val, atol = tol)
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

function test_nlp(optimizer; objective_tol = 1e-7, primal_tol = 1e-7, dual_tol = 1e-7)
    test_directory("nlp", optimizer; exclude = [
        "005_011",  # "Unrecognized function "\" used in nonlinear expression."
        "008_011",  # MethodError: no method matching getdual.
    ], objective_tol = objective_tol, primal_tol = primal_tol, dual_tol = dual_tol
    )
end

function test_nlp_cvx(optimizer; objective_tol = 1e-7, primal_tol = 1e-7, dual_tol = 1e-7)
    test_directory("nlp-cvx", optimizer;
        objective_tol = objective_tol, primal_tol = primal_tol, dual_tol = dual_tol
    )
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

function add_options(file_name)
    file = split(String(read(file_name)), "\n")
    open(file_name, "w") do io
        # Add the options to the first line
        write(io, replace(file[1], ")" => ", objective_tol, primal_tol, dual_tol)"), "\n")
        for line in file[2:end]
            if occursin("check_objective", line)
                line = replace(line, r"\)\r?$" => ", tol = objective_tol)")
            elseif occursin("check_solution", line)
                line = replace(line, r"\)\r?$" => ", tol = primal_tol)")
            elseif occursin("check_dual", line)
                line = replace(line, r"\)\r?$" => ", tol = dual_tol)")
            end
            write(io, line, "\n")
        end
    end
end

function convert_directory(directory)
    for file_name in filter(f -> endswith(f, ".jl"), readdir(directory))
        convert_file(joinpath(directory, file_name))
        add_options(joinpath(directory, file_name))
    end
end
