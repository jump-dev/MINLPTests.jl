function nlp_cvx_002_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective
    # - quadratic objective
    # - linear constraints forming an open set
    # Variants
    #   010 - binding constraints
    #   011 - non-binding constraints 
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, x+y)
    @constraint(m, 1*x-3*y <= 3)
    @constraint(m, 1*x-5*y <= 0)
    @constraint(m, 3*x+5*y >= 15)
    @constraint(m, 7*x+2*y >= 20)
    @constraint(m, 9*x+1*y >= 20)
    @constraint(m, 3*x+7*y >= 17)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 3.9655172067026196, tol = objective_tol)
    check_solution([x,y], [2.4137930845761546, 1.5517241221264648], tol = primal_tol)
    
end

