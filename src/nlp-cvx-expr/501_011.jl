# Copyright (c) 2021 MINLPTests.jl contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

function nlp_cvx_expr_501_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    function nd_shpere(n = 2)
        model = Model(optimizer)

        @variable(model, vars[1:n], start = 1 / n)

        @objective(model, Min, sum(-x for x in vars))
        @constraint(model, sqrt(sum(x^2 for x in vars)) <= 1.0)

        optimize!(model)

        #println(getobjectivevalue(model))

        check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
        check_objective(model, -n / sqrt(n), tol = objective_tol)
        return check_solution(
            vars,
            [1 / sqrt(n) for i in vars],
            tol = primal_tol,
        )
    end

    for n in 1:20
        nd_shpere(n)
    end
end
