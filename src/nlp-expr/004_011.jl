function nlp_expr_004_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - non-linear objective and linear, quadratic constraints as NL

    model = Model(optimizer)

    @variable(model, -1 <= x <= 1)
    @variable(model, y)
    @variable(model, z)

    @objective(model, Min, tan(x) + y + x * z + 0.5 * abs(y))
    @constraint(model, x^2 + y^2 + z^2 <= 10)
    @constraint(model, -1.2 * x - y <= z / 1.35)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -4.87215904079771, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [-1, -0.9160817459806899, 2.8567103830800886],
        tol = primal_tol,
    )
end
