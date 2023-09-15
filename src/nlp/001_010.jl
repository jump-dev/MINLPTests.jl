# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_001_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - mix of variable start values
    # - non-linear objective without constraints
    # - minimization objective
    # - functions ^, exp, cos

    model = Model(optimizer)

    @variable(model, x, start = 1)
    @variable(model, y, start = 2.12)
    @variable(model, z >= 1)

    @NLobjective(model, Min, x * exp(x) + cos(y) + z^3 - z^2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1.3678794486503105, tol = objective_tol)
    return check_solution([x, y, z], [-1, pi, 1], tol = primal_tol)
end
