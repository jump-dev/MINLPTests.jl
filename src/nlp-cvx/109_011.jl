# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_109_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x >= 0.00001, start = 0.1)
    @variable(model, y >= 0.00001, start = 0.1)

    @NLobjective(model, Max, log(x) + log(y))
    @NLconstraint(model, (y - 2)^2 <= -x + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.4853479762665618, tol = objective_tol)
    return check_solution(
        [x, y],
        [1.8499011869994715, 2.387425887570236],
        tol = primal_tol,
    )
end
