function nlp_cvx_expr_205_010(
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
    # - exponential cones
    # Variants
    #   010 - intersection set

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y >= 0, start = 0.1)
    @variable(model, z)

    @objective(model, Max, y)
    @constraint(model, y * exp(x / y) <= z)
    @constraint(model, y * exp(-x / y) <= z)
    @constraint(model, x^2 + y^2 <= -z + 5)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.7912878443121907, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [0.0, 1.7912878443121907, 1.7912878443121907],
        tol = primal_tol,
    )
end
