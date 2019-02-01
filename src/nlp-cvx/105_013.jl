function nlp_cvx_105_013(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x, start=0.1)
    @variable(m, y)
    
    @objective(m, Min, -x+y)
    @NLconstraint(m, exp(x-2.0) - 0.5 <= y)
    @NLconstraint(m, log(x) + 0.5 >= y)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -3/2, tol = objective_tol)
    check_solution([x,y], [2, 1/2], tol = primal_tol)
    
end

