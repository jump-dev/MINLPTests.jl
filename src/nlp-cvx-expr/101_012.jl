# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_101_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, -2 <= x <= 2)
    @variable(model, -2 <= y <= 2)

    @objective(model, Max, x)
    @constraint(model, x^2 + y^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1, tol = objective_tol)
    return check_solution([x, y], [1, 0], tol = primal_tol)
end