function nlp_cvx_101_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective
    # - single convex quadratic constraint
    # Variants
    #   010 - binding constraint (both variables non-zero)
    #   011 - binding constraint (one variable non-zero)
    #   012 - max objective
    
    m = Model(solver = optimizer)
    
    @variable(m, -2 <= x <= 2)
    @variable(m, -2 <= y <= 2)
    
    @objective(m, Min, -x-y)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -2/sqrt(2), tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/sqrt(2)], tol = primal_tol)
    
end

