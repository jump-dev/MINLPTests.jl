function nlp_cvx_expr_202_011(
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
    @variable(model, z)

    @objective(model, Min, z)
    @constraint(model, x^2 + y^2 <= z)
    @constraint(model, x^2 + y^2 <= -z + 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0, tol = objective_tol)
    return check_solution([x, y, z], [0, 0, 0], tol = primal_tol)
end
