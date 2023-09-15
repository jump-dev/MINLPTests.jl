# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_mi_004_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)

    # Test Goals:
    # - feasible model
    # - no objective
    # - discrete and non-discrete variables

    model = Model(optimizer)

    @variable(model, -1 <= x <= 1)
    @variable(model, y)
    @variable(model, z, Int)

    @NLconstraint(model, x^2 + y^2 + z^2 <= 10)
    @NLconstraint(model, -1.2 * x - y <= z / 1.35)
    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    # 0.0 as it doesn't have an objective
    return check_objective(model, 0.0, tol = objective_tol)
end
