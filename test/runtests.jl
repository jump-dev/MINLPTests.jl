using MINLPTests

using Test
using JuMP

using Ipopt
#using Juniper
#using KNITRO

ipopt = JuMP.with_optimizer(Ipopt.Optimizer, print_level=0)
#juniper = JuniperSolver(IpoptSolver(print_level=0), log_levels=[])
#knitro = JuMP.with_optimizer(KNITRO.Optimizer, outlev=0, opttol=1e-8)

nlp_solvers = [ipopt]
minlp_solvers = []
poly_solvers = [ipopt]
mipoly_solvers = []


@testset "JuMP Model Tests" begin
    for solver in nlp_solvers
        @testset "$(string(typeof(solver))) NLP Tests" begin
            MINLPTests.test_nlp(solver)
            MINLPTests.test_nlp_cvx(solver)
        end
    end

    for solver in minlp_solvers
        @testset "$(string(typeof(solver))) MINLP Tests" begin
            MINLPTests.test_nlp_mi(solver)
            MINLPTests.test_nlp_mi_cvx(solver)
        end
    end

    for solver in poly_solvers
        @testset "$(string(typeof(solver))) Polynomial Tests" begin
            MINLPTests.test_poly(solver)
            MINLPTests.test_poly_cvx(solver)
        end
    end

    for solver in mipoly_solvers
        @testset "$(string(typeof(solver))) MIPolynomial Tests" begin
            MINLPTests.test_poly_mi(solver)
            MINLPTests.test_poly_mi_cvx(solver)
        end
    end

end
