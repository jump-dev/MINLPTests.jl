using MINLPTests

using Test
using JuMP

using Ipopt

opt_tol = 1e-7
sol_tol = 1e-7

ipopt = IpoptSolver(print_level=0)

nlp_solvers = [ipopt]
minlp_solvers = []

global solver = ipopt


@testset "JuMP MINLP Tests" begin

for solver in nlp_solvers
    @testset "$(string(typeof(solver))) NLP Tests" begin
        include("nlp-cvx/tests.jl")
        include("nlp/tests.jl")
    end
end

for solver in minlp_solvers
    @testset "$(string(typeof(solver))) MINLP Tests" begin
        include("minlp-cvx/tests.jl")
        include("minlp/tests.jl")
    end
end

end