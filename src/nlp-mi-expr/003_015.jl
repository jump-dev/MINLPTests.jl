# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_mi_expr_003_015(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - quadratic objective as NLobjective and non-linear constraints

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4, Int)
    @variable(model, 0 <= y <= 4, Int)

    @objective(model, Max, x^2 + y)
    @constraint(model, y >= exp(x - 2) - 1.5)
    @constraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 11.0, tol = objective_tol)
    return check_solution([x, y], [3, 2], tol = primal_tol)
end
