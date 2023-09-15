# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_103_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # Variants
    #   010 - one binding constraint (inflection point)
    #   011 - one binding constraint (inflection point)
    #   012 - one binding constraint (non-inflection point)
    #   013 - one binding constraint (non-inflection point)
    #   014 - intersection point

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, y)
    @constraint(model, x^2 <= y)
    @constraint(model, -x^2 + 1 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0, tol = objective_tol)
    return check_solution([x, y], [0, 0], tol = primal_tol)
end
