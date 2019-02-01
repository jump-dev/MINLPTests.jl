function nlp_cvx_202_013(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, x+y+2*z)
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1/4, tol = objective_tol)
    check_solution([x,y,z], [-1/4, -1/4, 1/8], tol = primal_tol)
    
end

