function nlp_cvx_109_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0.00001, start=0.1)
    @variable(m, y >= 0.00001, start=0.1)
    
    @NLobjective(m, Max, log(x) + log(y))
    @NLconstraint(m, (y-2)^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.4853479762665618, tol = objective_tol)
    check_solution([x,y], [1.8499011869994715, 2.387425887570236], tol = primal_tol)
    
end

