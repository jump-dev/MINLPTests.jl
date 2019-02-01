function nlp_cvx_101_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, -2 <= x <= 2)
    @variable(m, -2 <= y <= 2)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y], [1, 0], tol = primal_tol)
    
end

