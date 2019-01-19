function test_nlp(s)
    global solver = s

    test_dir = dirname(@__FILE__)

    @testset "Nonconvex NLP Models" begin

    @testset  "unit tests" begin
        include(joinpath(test_dir, "001_010.jl"))
        include(joinpath(test_dir, "002_010.jl"))

        include(joinpath(test_dir, "003_010.jl"))
        include(joinpath(test_dir, "003_011.jl"))
        include(joinpath(test_dir, "003_012.jl"))
        include(joinpath(test_dir, "003_013.jl"))
        include(joinpath(test_dir, "003_014.jl"))
        include(joinpath(test_dir, "003_015.jl"))
        include(joinpath(test_dir, "003_016.jl"))

        include(joinpath(test_dir, "004_010.jl"))
        include(joinpath(test_dir, "004_011.jl"))

        include(joinpath(test_dir, "005_010.jl"))
        #include(joinpath(test_dir, "005_011.jl")) # "Unrecognized function "\" used in nonlinear expression."

        include(joinpath(test_dir, "006_010.jl"))

        include(joinpath(test_dir, "007_010.jl"))

        include(joinpath(test_dir, "008_010.jl"))
        #include(joinpath(test_dir, "008_011.jl")) # MethodError: no method matching getdual
    end

    end
end