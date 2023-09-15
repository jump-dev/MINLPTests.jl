# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_expr_009_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - max support

    model = Model(optimizer)

    @variable(model, x)

    @objective(model, Min, max(0.75 + (x - 0.5)^3, 0.75 + (x - 0.5)^2))

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.75, tol = objective_tol)
    check_solution([x], [0.5], tol = primal_tol)
    return
end
