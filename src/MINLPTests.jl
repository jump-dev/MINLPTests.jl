module MINLPTests
    using Test
    using JuMP

    include("common.jl")

    include("nlp/tests.jl")
    include("nlp-cvx/tests.jl")
    include("nlp-mi/tests.jl")
    include("nlp-mi-cvx/tests.jl")

    include("poly/tests.jl")
    include("poly-cvx/tests.jl")
    include("poly-mi/tests.jl")
    include("poly-mi-cvx/tests.jl")
end
