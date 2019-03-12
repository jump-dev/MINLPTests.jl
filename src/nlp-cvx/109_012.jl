function nlp_cvx_109_012(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0.00001, start=0.1)
    @variable(m, y >= 0.00001, start=0.1)
    
    @NLobjective(m, Max, log(x+y))
    @NLconstraint(m, (y-2)^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, log(7/4 + 5/2), tol = objective_tol)
    check_solution([x,y], [7/4, 5/2], tol = primal_tol)
    
end

