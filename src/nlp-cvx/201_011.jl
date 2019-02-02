function nlp_cvx_201_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y,z], [1, 0, 0], tol = primal_tol)
end

