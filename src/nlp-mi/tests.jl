function test_nlp_mi(s)
    global optimizer = s

    test_dir = dirname(@__FILE__)

    @testset "Nonconvex MINLP Models" begin

    @testset  "unit tests" begin
        include(joinpath(test_dir, "001_010.jl"))
        include(joinpath(test_dir, "002_010.jl"))

        include(joinpath(test_dir, "003_010.jl"))
        include(joinpath(test_dir, "003_011.jl"))
        include(joinpath(test_dir, "003_012.jl"))
        #include(joinpath(test_dir, "003_013.jl"))
        include(joinpath(test_dir, "003_014.jl"))
        include(joinpath(test_dir, "003_015.jl"))
        include(joinpath(test_dir, "003_016.jl"))

        # 003_013 generates - "Unrecognized expression x[1]. JuMP variable objects and input coefficients should be spliced directly into expressions."

        include(joinpath(test_dir, "004_010.jl"))
        include(joinpath(test_dir, "004_011.jl"))

        include(joinpath(test_dir, "005_010.jl"))
        # include(joinpath(test_dir, "005_011.jl")) # Unrecognized function "\" used in nonlinear expression.

        # include(joinpath(test_dir, "006_010.jl")) # KeyError: key :user_function_1d not found

        include(joinpath(test_dir, "007_010.jl"))
        include(joinpath(test_dir, "007_020.jl"))
    end

    end
end
