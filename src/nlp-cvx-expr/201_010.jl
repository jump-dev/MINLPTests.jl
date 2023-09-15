function nlp_cvx_expr_201_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - single convex quadratic constraint
    # Variants
    #   010 - binding constraint (all variables non-zero)
    #   011 - binding constraint (one variable non-zero)

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)
    @variable(model, z)

    @objective(model, Min, -(x + y + z))
    @constraint(model, x^2 + y^2 + z^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -3 / sqrt(3), tol = objective_tol)
    return check_solution(
        [x, y, z],
        [1 / sqrt(3), 1 / sqrt(3), 1 / sqrt(3)],
        tol = primal_tol,
    )
end
