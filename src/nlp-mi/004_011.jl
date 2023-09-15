# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_mi_004_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - non-linear objective and linear, quadratic constraints as NL

    model = Model(optimizer)

    @variable(model, -1 <= x <= 1)
    @variable(model, y)
    @variable(model, z, Int)

    @NLobjective(model, Min, tan(x) + y + x * z + 0.5 * abs(y))
    @NLconstraint(model, x^2 + y^2 + z^2 <= 10)
    @NLconstraint(model, -1.2 * x - y <= z / 1.35)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -4.5768813091909015, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [-0.9969558935432885, -0.07796881265504599, 3],
        tol = primal_tol,
    )
end
