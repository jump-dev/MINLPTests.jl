using Ipopt
using JuMP
using Juniper
using MINLPTests
using Test

const IPOPT =
    JuMP.optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0)

const JUNIPER = JuMP.optimizer_with_attributes() do
    return Juniper.Optimizer(nl_solver = IPOPT, log_levels = [])
end

const NLP_SOLVERS = [IPOPT]
const MINLP_SOLVERS = [JUNIPER]
const POLY_SOLVERS = [IPOPT]
const MIPOLY_SOLVERS = [JUNIPER]

@testset "JuMP Model Tests" begin
    @testset "$(solver): nlp" for solver in NLP_SOLVERS
        MINLPTests.test_nlp(
            solver,
            exclude = ["005_011"],  # Uses the function `\`
            debug = true,
        )
        MINLPTests.test_nlp_cvx(solver)
    end
    @testset "$(solver): nlp_mi" for solver in MINLP_SOLVERS
        MINLPTests.test_nlp_mi(solver, exclude = [
            "005_011",  # Uses the function `\`
            "006_010",  # Bug in Juniper - handling of user-defined functions.
        ])
        MINLPTests.test_nlp_mi_cvx(solver)
    end
    @testset "$(solver): poly" for solver in POLY_SOLVERS
        MINLPTests.test_poly(solver)
        MINLPTests.test_poly_cvx(solver)
    end
    @testset "$(solver): poly_mi" for solver in MIPOLY_SOLVERS
        MINLPTests.test_poly_mi(solver)
        MINLPTests.test_poly_mi_cvx(solver)
    end
end
