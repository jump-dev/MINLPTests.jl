function nlp_cvx_expr_103_013(
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

    @objective(model, Min, x + y)
    @constraint(model, x^2 <= y)
    @constraint(model, -x^2 + 1 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1 / 4, tol = objective_tol)
    return check_solution([x, y], [-1 / 2, 1 / 4], tol = primal_tol)
end
