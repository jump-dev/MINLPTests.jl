function nlp_cvx_expr_107_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - convex objective
    # - single simple constraint
    # Variants
    #   010 - no binding constraints
    #   011 - binding constraint
    #   012 - binding constraint, different starting point

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, (x - 0.5)^2 + (y - 0.5)^2)
    @constraint(model, x^2 + y^2 <= 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0, tol = objective_tol)
    return check_solution([x, y], [1 / 2, 1 / 2], tol = primal_tol)
end
