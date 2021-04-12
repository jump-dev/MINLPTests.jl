function nlp_cvx_105_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    model = Model(optimizer)

    @variable(model, x, start = 0.1)
    @variable(model, y)

    @objective(model, Min, x - y)
    @NLconstraint(model, exp(x - 2.0) - 0.5 <= y)
    @NLconstraint(model, log(x) + 0.5 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1 / 2, tol = objective_tol)
    return check_solution([x, y], [1, 1 / 2], tol = primal_tol)
end
