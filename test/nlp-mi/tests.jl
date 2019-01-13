@testset "Nonconvex MINLP Models" begin

@testset  "unit tests" begin
    include("001_010.jl")
    include("002_010.jl")

    include("003_010.jl")
    include("003_011.jl")
    include("003_012.jl")
    #include("003_013.jl")
    include("003_014.jl")
    include("003_015.jl")
    include("003_016.jl")

    # 003_013 generates - "Unrecognized expression x[1]. JuMP variable objects and input coefficients should be spliced directly into expressions."

    include("004_010.jl")
    include("004_011.jl")

    include("005_010.jl")
    # include("005_011.jl") # Unrecognized function "\" used in nonlinear expression.

    # include("006_010.jl") # KeyError: key :user_function_1d not found

    include("007_010.jl")
    include("007_020.jl")
end

end