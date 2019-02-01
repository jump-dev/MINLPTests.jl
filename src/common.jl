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
