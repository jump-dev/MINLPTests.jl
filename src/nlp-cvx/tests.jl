function test_nlp_cvx(s)
    global solver = s

    test_dir = dirname(@__FILE__)

    @testset "Convex NLP Models" begin

    @testset  "unit tests" begin
        include(joinpath(test_dir, "001_010.jl"))
        include(joinpath(test_dir, "001_011.jl"))

        include(joinpath(test_dir, "002_010.jl"))
        include(joinpath(test_dir, "002_011.jl"))
    end

    @testset "2D tests" begin
        include(joinpath(test_dir, "101_010.jl"))
        include(joinpath(test_dir, "101_011.jl"))
        include(joinpath(test_dir, "101_012.jl"))

        include(joinpath(test_dir, "103_010.jl"))
        include(joinpath(test_dir, "103_011.jl"))
        include(joinpath(test_dir, "103_012.jl"))
        include(joinpath(test_dir, "103_013.jl"))
        include(joinpath(test_dir, "103_014.jl"))

        include(joinpath(test_dir, "104_010.jl"))

        include(joinpath(test_dir, "105_010.jl"))
        include(joinpath(test_dir, "105_011.jl"))
        include(joinpath(test_dir, "105_012.jl"))
        include(joinpath(test_dir, "105_013.jl"))

        include(joinpath(test_dir, "106_010.jl"))
        include(joinpath(test_dir, "106_011.jl"))

        include(joinpath(test_dir, "107_010.jl"))
        include(joinpath(test_dir, "107_011.jl"))
        include(joinpath(test_dir, "107_012.jl"))

        include(joinpath(test_dir, "108_010.jl"))
        include(joinpath(test_dir, "108_011.jl"))
        include(joinpath(test_dir, "108_012.jl"))
        include(joinpath(test_dir, "108_013.jl"))

        include(joinpath(test_dir, "109_010.jl"))
        include(joinpath(test_dir, "109_011.jl"))
        include(joinpath(test_dir, "109_012.jl"))

        include(joinpath(test_dir, "110_010.jl"))
        include(joinpath(test_dir, "110_011.jl"))
        include(joinpath(test_dir, "110_012.jl"))
    end

    @testset "3D tests" begin
        include(joinpath(test_dir, "201_010.jl"))
        include(joinpath(test_dir, "201_011.jl"))

        include(joinpath(test_dir, "202_010.jl"))
        include(joinpath(test_dir, "202_011.jl"))
        include(joinpath(test_dir, "202_012.jl"))
        include(joinpath(test_dir, "202_013.jl"))
        include(joinpath(test_dir, "202_014.jl"))

        include(joinpath(test_dir, "203_010.jl"))

        include(joinpath(test_dir, "204_010.jl"))

        include(joinpath(test_dir, "210_010.jl"))
        include(joinpath(test_dir, "210_011.jl"))
        include(joinpath(test_dir, "210_012.jl"))
    end

    @testset "nD tests" begin
        include(joinpath(test_dir, "501_010.jl"))
        include(joinpath(test_dir, "501_011.jl"))
    end

    end

end
