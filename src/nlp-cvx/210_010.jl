function nlp_cvx_210_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - convex objective
    # - convex quadratic constraint
    # Variants
    #   010 - no binding constraints
    #   011 - binding constraint
    #   012 - binding constraint, different starting point
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, (x-0.5)^2 + (y-0.5)^2 + (z-0.5)^2)
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.0, tol = objective_tol)
    check_solution([x,y,z], [1/2, 1/2, 1/2], tol = primal_tol)
    
end

