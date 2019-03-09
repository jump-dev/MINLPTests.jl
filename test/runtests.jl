using MINLPTests, JuMP, Test

using Ipopt 
const IPOPT = JuMP.with_optimizer(Ipopt.Optimizer, print_level = 0)

const NLP_SOLVERS = [IPOPT]
const MINLP_SOLVERS = []
const POLY_SOLVERS = [IPOPT]
const MIPOLY_SOLVERS = []

@testset "JuMP Model Tests" begin
    @testset "$(solver.constructor): nlp" for solver in NLP_SOLVERS
        MINLPTests.test_nlp(solver, exclude = [
            "005_010",  # Ipopt needs relaxed tolerances.
            "005_011",  # Uses the function `\`
            "008_011"   # Requires quadratic duals
        ])
        @testset "nlp_cvx_005_010" begin
            MINLPTests.nlp_005_010(solver, 1e-5, 1e-5, 1e-5)
        end
        MINLPTests.test_nlp_cvx(solver, exclude = [
            "109_011"  # Ipopt needs relaxed tolerances.
        ])
        @testset "nlp_cvx_109_011" begin
            MINLPTests.nlp_cvx_109_011(solver, 1e-7, 1e-6, 1e-7,
                termination_target = JuMP.MOI.ALMOST_LOCALLY_SOLVED,
                primal_target = JuMP.MOI.NEARLY_FEASIBLE_POINT)
        end
    end
    @testset "$(solver.constructor): nlp_mi" for solver in MINLP_SOLVERS
        MINLPTests.test_nlp_mi(solver, exclude = [
            "005_011",  # Uses the function `\`
            "003_010",  # solution changed between Juniper v0.2.4 and v0.2.5
            "003_011",  # solution changed between Juniper v0.2.4 and v0.2.5
            "003_012",  # solution changed between Juniper v0.2.4 and v0.2.5
            "003_013",  # Bug in Juniper - handling of expression graph?
            "003_016",  # solution changed between Juniper v0.2.4 and v0.2.5
            "006_010"   # Bug in Juniper - handling of user-defined functions.
        ])
        MINLPTests.test_nlp_mi_cvx(solver)
    end
    @testset "$(solver.constructor): poly" for solver in POLY_SOLVERS
        MINLPTests.test_poly(solver)
        MINLPTests.test_poly_cvx(solver)
    end
    @testset "$(solver.constructor): poly_mi" for solver in MIPOLY_SOLVERS
        MINLPTests.test_poly_mi(solver)
        MINLPTests.test_poly_mi_cvx(solver)
    end
end
