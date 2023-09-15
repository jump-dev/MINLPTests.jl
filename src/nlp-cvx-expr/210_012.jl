# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_210_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x, start = 1.5)
    @variable(model, y, start = 1.0)
    @variable(model, z, start = 0.5)

    @objective(model, Min, (x - 1.0)^2 + (y - 1.0)^2 + (z - 1.0)^2)
    @constraint(model, x^2 + y^2 + z^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.535898380052066, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [1 / sqrt(3), 1 / sqrt(3), 1 / sqrt(3)],
        tol = primal_tol,
    )
end
