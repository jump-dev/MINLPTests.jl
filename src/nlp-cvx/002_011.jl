# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_002_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, (x - 3)^2 + (y - 2)^2)
    @constraint(model, 1 * x - 3 * y <= 3)
    @constraint(model, 1 * x - 5 * y <= 0)
    @constraint(model, 3 * x + 5 * y >= 15)
    @constraint(model, 7 * x + 2 * y >= 20)
    @constraint(model, 9 * x + 1 * y >= 20)
    @constraint(model, 3 * x + 7 * y >= 17)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0, tol = objective_tol)
    return check_solution([x, y], [3, 2], tol = primal_tol)
end
