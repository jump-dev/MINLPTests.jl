@testset "Convex NLP Models" begin

@testset  "miscellaneous tests" begin
    include("001_010.jl")
    include("001_011.jl")

    include("002_010.jl")
    include("002_011.jl")
end

@testset "2D tests" begin
    include("101_010.jl")
    include("101_011.jl")
    include("101_012.jl")

    include("103_010.jl")
    include("103_011.jl")
    include("103_012.jl")
    include("103_013.jl")
    include("103_014.jl")

    include("104_010.jl")

    include("105_010.jl")
    include("105_011.jl")
    include("105_012.jl")
    include("105_013.jl")

    include("106_010.jl")
    include("106_011.jl")

    include("107_010.jl")
    include("107_011.jl")
    include("107_012.jl")

    include("108_010.jl")
    include("108_011.jl")
    include("108_012.jl")
    include("108_013.jl")

    include("109_010.jl")
    include("109_011.jl")
    include("109_012.jl")

    include("110_010.jl")
    include("110_011.jl")
    include("110_012.jl")
end

@testset "3D tests" begin
    include("201_010.jl")
    include("201_011.jl")

    include("202_010.jl")
    include("202_011.jl")
    include("202_012.jl")
    include("202_013.jl")
    include("202_014.jl")

    include("203_010.jl")

    include("204_010.jl")

    include("210_010.jl")
    include("210_011.jl")
    include("210_012.jl")
end

@testset "nD tests" begin
    include("501_010.jl")
end

end
