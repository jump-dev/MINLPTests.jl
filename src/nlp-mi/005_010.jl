function nlp_mi_005_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - function /

    model = Model(optimizer)

    @variable(model, x >= 0, Int)
    @variable(model, y >= 0)

    @objective(model, Min, x + y)
    @NLconstraint(model, y >= 1 / (x + 0.1) - 0.5)
    @NLconstraint(model, x >= y^(-2) - 0.5)
    @NLconstraint(model, 4 / (x + y + 0.1) >= 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.8164965727459055, tol = objective_tol)
    return check_solution([x, y], [1, 0.816496581496872], tol = primal_tol)
end
