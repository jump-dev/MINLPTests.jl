# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_206_010(
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
    # - power cones
    # Variants
    #   010 - intersection set

    model = Model(optimizer)

    # NOTE, starting any of these at 0.0 will segfault libcoinmumps
    @variable(model, x >= 0, start = 0.1)
    @variable(model, y >= 0, start = 0.1)
    @variable(model, z >= 0, start = 0.1)

    @objective(model, Max, 2 * x + y + z)
    @constraint(model, z <= x^(0.3) * y^(0.7))
    @constraint(model, x <= z^(0.7) * y^(0.3))
    @constraint(model, x^2 + y^2 <= z + 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 4.0, tol = objective_tol)
    return check_solution([x, y, z], [1, 1, 1], tol = primal_tol)
end
