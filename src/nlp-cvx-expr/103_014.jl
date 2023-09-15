function nlp_cvx_expr_103_014(
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

    @objective(model, Min, -x)
    @constraint(model, x^2 <= y)
    @constraint(model, -x^2 + 1 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1 / sqrt(2), tol = objective_tol)
    return check_solution([x, y], [1 / sqrt(2), 1 / 2], tol = primal_tol)
end
