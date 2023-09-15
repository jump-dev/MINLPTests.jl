# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_expr_003_016(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - objective with offset

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4)
    @variable(model, 0 <= y <= 4)

    @objective(model, Max, x + pi)
    @constraint(model, y >= exp(x - 2) - 1.5)
    @constraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 6.398105319414242, tol = objective_tol)
    return check_solution(
        [x, y],
        [3.2565126525233166, 2.013148549981813],
        tol = primal_tol,
    )
end
