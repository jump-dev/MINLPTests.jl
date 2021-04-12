function nlp_cvx_107_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x, start = 1.5)
    @variable(model, y, start = 0.5)

    @objective(model, Min, (x - 1.0)^2 + (y - 1.0)^2)
    @NLconstraint(model, x^2 + y^2 <= 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.17157287363083387, tol = objective_tol)
    return check_solution([x, y], [1 / sqrt(2), 1 / sqrt(2)], tol = primal_tol)
end
