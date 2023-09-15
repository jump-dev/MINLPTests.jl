# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_105_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - e and log expressions
    # - convex constraint, only in given domains
    # Variants
    #   010 - intersection point
    #   011 - intersection point
    #   012 - one binding constraint
    #   013 - one binding constraint

    model = Model(optimizer)

    @variable(model, x, start = 0.1)
    @variable(model, y)

    @objective(model, Min, -x - y)
    @constraint(model, exp(x - 2.0) - 0.5 <= y)
    @constraint(model, log(x) + 0.5 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -4.176004405036646, tol = objective_tol)
    return check_solution(
        [x, y],
        [2.687422019398147, 1.488582385638499],
        tol = primal_tol,
    )
end
