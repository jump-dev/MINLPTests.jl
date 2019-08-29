function nlp_cvx_205_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # - exponential cones
    # Variants
    #   010 - intersection set

    m = Model(optimizer)

    @variable(m, x)
    @variable(m, y >= 0, start=0.1)
    @variable(m, z)

    @objective(m, Max, y)
    @NLconstraint(m, y * exp(x / y) <= z)
    @NLconstraint(m, y * exp(-x / y) <= z)
    @NLconstraint(m, x^2 + y^2 <= -z + 5)

    optimize!(m)

    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 1.7912878443121907, tol = objective_tol)
    check_solution([x,y,z], [0.0, 1.7912878443121907, 1.7912878443121907], tol = primal_tol)

end
