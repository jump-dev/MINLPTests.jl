function nlp_mi_expr_003_016(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - objective with offset

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4, Int)
    @variable(model, 0 <= y <= 4, Int)

    @objective(model, Max, x + pi)
    @constraint(model, y >= exp(x - 2) - 1.5)
    @constraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 6.141592682680717, tol = objective_tol)
    return check_solution([x, y], [3, 2], tol = primal_tol)
end
