function nlp_cvx_105_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x, start=0.1)
    @variable(m, y)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, exp(x-2.0) - 0.5 <= y)
    @NLconstraint(m, log(x) + 0.5 >= y)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.16878271368156372, tol = objective_tol)
    check_solution([x,y], [0.45538805755556067, -0.28660534387399694], tol = primal_tol)
    
end

