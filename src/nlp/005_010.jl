function nlp_005_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - function /
    
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, x + y)
    @NLconstraint(m, y >= 1/(x+0.1) - 0.5)
    @NLconstraint(m, x >= y^(-2) - 0.5)
    @NLconstraint(m, 4 / (x+y+0.1) >= 1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.5449760741521967, tol = objective_tol)
    check_solution([x,y], [0.5848970571378771, 0.9600790170143196], tol = primal_tol)
    
end

