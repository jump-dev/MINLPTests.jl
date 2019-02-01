function nlp_cvx_202_014(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y,z], [-1/2, -1/2, 1/2], tol = primal_tol)
    
end

