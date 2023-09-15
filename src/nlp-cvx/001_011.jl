# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_001_011(
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

    @objective(model, Min, (x - 1)^2 + (y - 2)^2)
    @constraint(model, x + y <= 5)
    @constraint(model, 2 * x - y <= 3)
    @constraint(model, 3 * x + 9 * y >= -10)
    @constraint(model, 10 * x - y >= -20)
    @constraint(model, -x + 2 * y <= 8)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.0, tol = objective_tol)
    return check_solution([x, y], [1.0, 2.0], tol = primal_tol)
end
