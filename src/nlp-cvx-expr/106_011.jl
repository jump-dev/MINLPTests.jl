function nlp_cvx_expr_106_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, -3 <= x <= 3)
    @variable(model, -1 <= y <= 1)

    @objective(model, Min, x + y)
    @constraint(model, sin(-x - 1.0) + x / 2 + 0.5 <= y)
    @constraint(model, cos(x - 0.5) + x / 4 - 0.5 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -0.7868226265935826, tol = objective_tol)
    return check_solution(
        [x, y],
        [-0.5955231764562057, -0.1912994501373769],
        tol = primal_tol,
    )
end
