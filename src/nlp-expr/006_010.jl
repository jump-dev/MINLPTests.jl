# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_expr_006_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - user defined functions

    model = Model(optimizer)

    function user_function_1d(x)
        if x >= 0
            return max(0.25, exp(x) - 1)
        else
            return log(-x + 3)
        end
    end
    @operator(model, f_1d, 1, user_function_1d)

    function user_function_2d(x, y)
        return x^2 + y^3
    end
    @operator(model, f_2d, 2, user_function_2d)

    @variable(model, x)
    @variable(model, y >= 0)

    @objective(model, Max, y + x)
    @constraint(model, y >= f_1d(x))
    @constraint(model, f_2d(x, y) <= 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.8813786425753092, tol = objective_tol)
    return check_solution(
        [x, y],
        [0.7546057578960682, 1.1267728846792409],
        tol = primal_tol,
    )
end
