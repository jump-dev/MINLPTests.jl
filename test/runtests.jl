using MINLPTests, JuMP, Test

using Ipopt, Juniper
const IPOPT = JuMP.with_optimizer(Ipopt.Optimizer, print_level = 0)
const JUNIPER = JuMP.with_optimizer(Juniper.Optimizer, nl_solver=JuMP.with_optimizer(Ipopt.Optimizer, print_level=0), log_levels=[])


const NLP_SOLVERS = [IPOPT]
const MINLP_SOLVERS = [JUNIPER]
const POLY_SOLVERS = [IPOPT]
const MIPOLY_SOLVERS = [JUNIPER]

@testset "JuMP Model Tests" begin
    @testset "$(solver): nlp" for solver in NLP_SOLVERS
        #MINLPTests.test_nlp(solver)
        MINLPTests.test_nlp(solver, exclude = [
            "005_011",  # Uses the function `\`
        ])
        MINLPTests.test_nlp_cvx(solver)
    end
    @testset "$(solver): nlp_mi" for solver in MINLP_SOLVERS
        #MINLPTests.test_nlp_mi(solver)
        MINLPTests.test_nlp_mi(solver, exclude = [
            "003_013",  # Bug in Juniper - handling of expression graph?
            "005_011",  # Uses the function `\`
            "006_010"   # Bug in Juniper - handling of user-defined functions.
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
