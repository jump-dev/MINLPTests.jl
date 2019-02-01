function nlp_cvx_001_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective
    # - quadratic objective
    # - linear constraints forming a closed set
    # Variants
    #   010 - binding constraints
    #   011 - non-binding constraints 
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, x)
    @constraint(m, x+y <= 5)
    @constraint(m, 2*x-y <= 3)
    @constraint(m, 3*x+9*y >= -10)
    @constraint(m, 10*x-y >= -20)
    @constraint(m, -x+2*y <= 8)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -2.0430107680954848, tol = objective_tol)
    check_solution([x,y], [-2.0430107680954848, -0.4301075068564087], tol = primal_tol)
    
end

