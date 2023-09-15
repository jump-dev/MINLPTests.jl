# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_mi_expr_003_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - none have start values
    # - non-linear objective and non-linear constraints
    # - maximization objective
    # - variable bounds
    # - functions sqrt, sin
    # - integer variables

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4, Int)
    @variable(model, 0 <= y <= 4, Int)

    @objective(model, Max, sqrt(x + 0.1))
    @constraint(model, y >= exp(x - 2) - 1.5)
    @constraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.7606816937762844, tol = objective_tol)
    return check_solution([x, y], [3, 2], tol = primal_tol)
end
