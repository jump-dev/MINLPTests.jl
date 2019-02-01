module MINLPTests
    using Test
    using JuMP

    include("common.jl")

    for directory in ["nlp", "nlp-cvx"]
        for file_name in filter(f -> endswith(f, ".jl"), readdir(joinpath(@__DIR__, directory)))
            include(joinpath(@__DIR__, directory, file_name))
        end
    end

    # include("nlp-mi/tests.jl")
    # include("nlp-mi-cvx/tests.jl")
    #
    # include("poly/tests.jl")
    # include("poly-cvx/tests.jl")
    # include("poly-mi/tests.jl")
    # include("poly-mi-cvx/tests.jl")
end
