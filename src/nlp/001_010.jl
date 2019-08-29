function nlp_001_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    # Test Goals:
    # - mix of variable start values
    # - non-linear objective without constraints
    # - minimization objective
    # - functions ^, exp, cos

    m = Model(optimizer)

    @variable(m, x, start=1)
    @variable(m, y, start=2.12)
    @variable(m, z >= 1)

    @NLobjective(m, Min, x*exp(x) + cos(y) + z^3 - z^2)

    optimize!(m)

    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, -1.3678794486503105, tol = objective_tol)
    check_solution([x,y,z], [-1, pi, 1], tol = primal_tol)

end
