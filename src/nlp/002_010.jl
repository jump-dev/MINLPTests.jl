function nlp_002_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - all have start values
    # - non-linear constraints without objective
    # - functions log

    model = Model(optimizer)

    @variable(model, x, start = 1)
    @variable(model, y, start = -1.12)

    @NLconstraint(model, y == log(x) - 0.1)
    @NLconstraint(model, x == cos(y)^2 + 1.5)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 0.0, tol = objective_tol)
    return check_solution(
        [x, y],
        [2.1285148443189033, 0.6554244804634232],
        tol = primal_tol,
    )
end
