function nlp_cvx_206_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # - power cones
    # Variants
    #   010 - intersection set
    
    m = Model(solver = optimizer)
    
    # NOTE, starting any of these at 0.0 will segfault libcoinmumps
    @variable(m, x >= 0, start=0.1)
    @variable(m, y >= 0, start=0.1)
    @variable(m, z >= 0, start=0.1)
    
    @objective(m, Max, 2*x+y+z)
    @NLconstraint(m, z <= x^(0.3)*y^(0.7))
    @NLconstraint(m, x <= z^(0.7)*y^(0.3))
    @NLconstraint(m, x^2 + y^2 <= z+1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 4.0, tol = objective_tol)
    check_solution([x,y,z], [1, 1, 1], tol = primal_tol)
    
end

