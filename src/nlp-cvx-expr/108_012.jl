# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_108_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x >= 0)
    @variable(model, y >= 0)

    @objective(model, Min, x^2 + (y - 2)^2)
    @constraint(model, 2 * x^2 - 4x * y - 4 * x + 4 <= y)
    @constraint(model, y^2 <= -x + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.5927195187027438, tol = objective_tol)
    return check_solution(
        [x, y],
        [0.31567986647277146, 1.2978135998137839],
        tol = primal_tol,
    )
end
