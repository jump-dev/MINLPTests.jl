function nlp_cvx_expr_110_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, exp(x + y))
    @constraint(model, x^2 + y^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, exp(-2 / sqrt(2)), tol = objective_tol)
    return check_solution(
        [x, y],
        [-1 / sqrt(2), -1 / sqrt(2)],
        tol = primal_tol,
    )
end
