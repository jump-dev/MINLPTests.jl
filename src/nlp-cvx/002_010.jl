# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_002_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - quadratic objective
    # - linear constraints forming an open set
    # Variants
    #   010 - binding constraints
    #   011 - non-binding constraints

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, x + y)
    @constraint(model, 1 * x - 3 * y <= 3)
    @constraint(model, 1 * x - 5 * y <= 0)
    @constraint(model, 3 * x + 5 * y >= 15)
    @constraint(model, 7 * x + 2 * y >= 20)
    @constraint(model, 9 * x + 1 * y >= 20)
    @constraint(model, 3 * x + 7 * y >= 17)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 3.9655172067026196, tol = objective_tol)
    return check_solution(
        [x, y],
        [2.4137930845761546, 1.5517241221264648],
        tol = primal_tol,
    )
end
