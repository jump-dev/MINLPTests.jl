function nlp_cvx_201_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective
    # - single convex quadratic constraint
    # Variants
    #   010 - binding constraint (all variables non-zero)
    #   011 - binding constraint (one variable non-zero)
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, -(x+y+z))
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -3/sqrt(3), tol = objective_tol)
    check_solution([x,y,z], [1/sqrt(3), 1/sqrt(3), 1/sqrt(3)], tol = primal_tol)
    
end

