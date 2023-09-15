function nlp_cvx_expr_108_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - convex objective
    # - intersection of constraints
    # - convex constraint, only in positive domain
    # Variants
    #   010 - no binding constraints
    #   011 - intersection point
    #   012 - intersection point
    #   013 - one binding constraint

    model = Model(optimizer)

    @variable(model, x >= 0)
    @variable(model, y >= 0)

    @objective(model, Min, (x - 1.0)^2 + (y - 0.75)^2)
    @constraint(model, 2 * x^2 - 4x * y - 4 * x + 4 <= y)
    @constraint(model, y^2 <= -x + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0, tol = objective_tol)
    return check_solution([x, y], [1, 0.75], tol = primal_tol)
end
