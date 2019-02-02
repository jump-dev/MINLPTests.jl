function nlp_cvx_109_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - convex logarithmic objective
    # - binding nonlinear constraint
    # Variants
    #   010 - binding constraint (inflection point)
    #   011 - binding constraint (non-inflection point)
    #   012 - binding constraint (non-inflection point)

    m = Model(optimizer)

    @variable(m, x, start=1.0)
    @variable(m, y, start=1.0)

    @NLobjective(m, Max, log(x))
    @NLconstraint(m, (y-2)^2 <= -x+2)

    optimize!(m)

    check_status(m)
    check_objective(m, log(2), tol = objective_tol)
    check_solution([x,y], [2, 2], tol = primal_tol)

end
