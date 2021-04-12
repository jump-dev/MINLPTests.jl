function nlp_cvx_104_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - redundant nonlinear constraint (feasible set is inside the circle constraint)
    # Variants
    #   010 - redundant constraint

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)

    @objective(model, Min, -x)
    @NLconstraint(model, x^2 <= y)
    @NLconstraint(model, -x^2 + 1 >= y)
    @NLconstraint(model, x^2 + (y - 0.5)^2 <= 1.0)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1 / sqrt(2), tol = objective_tol)
    return check_solution([x, y], [1 / sqrt(2), 1 / 2], tol = primal_tol)
end
