function nlp_cvx_107_012(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x, start = 1.5)
    @variable(m, y, start = 0.5)
    
    @objective(m, Min, (x-1.0)^2 + (y-1.0)^2)
    @NLconstraint(m, x^2 + y^2 <= 1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.17157287363083387, tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/sqrt(2)], tol = primal_tol)
    
end

