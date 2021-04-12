function nlp_cvx_106_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - cos and sin expressions
    # - convex constraint, only in given domains
    # Variants
    #   010 - intersection point
    #   011 - intersection point

    model = Model(optimizer)

    @variable(model, -3 <= x <= 3)
    @variable(model, -1 <= y <= 1)

    @objective(model, Min, -x - y)
    @NLconstraint(model, sin(-x - 1.0) + x / 2 + 0.5 <= y)
    @NLconstraint(model, cos(x - 0.5) + x / 4 - 0.5 >= y)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1.8572155128552428, tol = objective_tol)
    return check_solution(
        [x, y],
        [1.369771397576555, 0.4874441152786876],
        tol = primal_tol,
    )
end
