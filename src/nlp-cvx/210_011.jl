function nlp_cvx_210_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, (x-1.0)^2 + (y-1.0)^2 + (z-1.0)^2)
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.535898380052066, tol = objective_tol)
    check_solution([x,y,z], [1/sqrt(3), 1/sqrt(3), 1/sqrt(3)], tol = primal_tol)
    
end

