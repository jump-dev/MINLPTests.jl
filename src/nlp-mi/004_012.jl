function nlp_mi_004_012(optimizer, objective_tol, primal_tol, dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL)

    # Test Goals:
    # - feasible model
    # - no objective
    # - discrete and non-discrete variables

    m = Model(optimizer)

    @variable(m, -1 <= x <= 1)
    @variable(m, y)
    @variable(m, z, Int)

    @NLconstraint(m, x^2 + y^2 + z^2 <= 10)
    @NLconstraint(m, -1.2*x - y <= z/1.35)
    optimize!(m)

    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    # 0.0 as it doesn't have an objective
    check_objective(m, 0.0, tol = objective_tol)
end
