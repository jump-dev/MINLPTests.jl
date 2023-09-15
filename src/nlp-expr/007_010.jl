# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_expr_007_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - infeasible model

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @constraint(model, y == exp(x))
    @constraint(model, x == y^2)

    optimize!(model)

    return check_status(
        model,
        INFEASIBLE_PROBLEM,
        termination_target,
        primal_target,
    )
end
