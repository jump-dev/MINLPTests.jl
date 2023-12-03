# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

using Test

import Ipopt
import JuMP
import Juniper
import MINLPTests

const IPOPT =
    JuMP.optimizer_with_attributes(Ipopt.Optimizer, "print_level" => 0)

const JUNIPER = JuMP.optimizer_with_attributes() do
    return Juniper.Optimizer(; nl_solver = IPOPT, log_levels = [])
end

const NLP_SOLVERS = [IPOPT]
const MINLP_SOLVERS = [JUNIPER]
const POLY_SOLVERS = [IPOPT]
const MIPOLY_SOLVERS = [JUNIPER]

@testset "JuMP Model Tests" begin
    @testset "$(solver): nlp" for solver in NLP_SOLVERS
        MINLPTests.test_nlp(solver; debug = true, exclude = ["001_010"])
        MINLPTests.test_directory("nlp", solver, include = ["001_010"])
        MINLPTests.test_nlp_cvx(solver)
        MINLPTests.test_nlp_expr(solver)
        MINLPTests.test_nlp_cvx_expr(solver)
    end
    @testset "$(solver): nlp_mi" for solver in MINLP_SOLVERS
        MINLPTests.test_nlp_mi(solver)
        MINLPTests.test_nlp_mi_expr(solver)
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
