function nlp_mi_expr_002_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - all have start values
    # - non-linear constraints without objective
    # - functions log
    # - binary variable

    model = Model(optimizer)

    @variable(model, x >= 0.9, start = 1, Int)
    @variable(model, y, start = -1.12, Bin)

    @constraint(model, y <= log(x) - 0.1)
    @constraint(model, x <= cos(y)^2 + 1.5)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.0, tol = objective_tol)
    return check_solution([x, y], [2, 0], tol = primal_tol)
end
