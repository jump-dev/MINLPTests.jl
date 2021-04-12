function nlp_mi_003_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective and non-linear constraints

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4, Int)
    @variable(model, 0 <= y <= 4, Int)

    @objective(model, Max, x)
    @NLconstraint(model, y >= exp(x - 2) - 1.5)
    @NLconstraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 3, tol = objective_tol)
    return check_solution([x, y], [3, 2], tol = primal_tol)
end
