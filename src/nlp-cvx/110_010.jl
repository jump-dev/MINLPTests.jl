function nlp_cvx_110_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - convex e objective
    # - binding nonlinear constraint
    # Variants
    #   010 - binding constraint (one variable non-zero)
    #   011 - binding constraint (both variables non-zero)
    #   012 - binding constraint (both variables non-zero)
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @NLobjective(m, Min, exp(x))
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, exp(-1), tol = objective_tol)
    check_solution([x,y], [-1.0, 0.0], tol = primal_tol)
    
end

