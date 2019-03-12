function nlp_cvx_109_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - convex logarithmic objective
    # - binding nonlinear constraint
    # Variants
    #   010 - binding constraint (inflection point)
    #   011 - binding constraint (non-inflection point)
    #   012 - binding constraint (non-inflection point)
    
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0.00001, start=0.1)
    @variable(m, y >= 0.00001, start=0.1)
    
    @NLobjective(m, Max, log(x))
    @NLconstraint(m, (y-2)^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, log(2), tol = objective_tol)
    check_solution([x,y], [2, 2], tol = primal_tol)
    
end

