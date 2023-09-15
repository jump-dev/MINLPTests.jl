function nlp_cvx_expr_203_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # - sqrt cone
    # Variants
    #   010 - intersection set

    model = Model(optimizer)

    @variable(model, x, start = 0.1)
    @variable(model, y, start = 0.1)
    @variable(model, z)

    @objective(model, Min, x + y)
    @constraint(model, sqrt(x^2 + y^2) <= z - 0.25)
    @constraint(model, x^2 + y^2 <= -z + 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1 / sqrt(2), tol = objective_tol)
    return check_solution(
        [x, y, z],
        [-sqrt(1 / 8), -sqrt(1 / 8), 3 / 4],
        tol = primal_tol,
    )
end
