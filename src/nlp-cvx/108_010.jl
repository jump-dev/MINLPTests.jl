function nlp_cvx_108_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - convex objective
    # - intersection of constraints
    # - convex constraint, only in positive domain
    # Variants
    #   010 - no binding constraints
    #   011 - intersection point
    #   012 - intersection point
    #   013 - one binding constraint
    
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, (x-1.0)^2 + (y-0.75)^2)
    @NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
    @NLconstraint(m, y^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0, tol = objective_tol)
    check_solution([x,y], [1, 0.75], tol = primal_tol)
    
end

