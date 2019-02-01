function nlp_cvx_202_012(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, -(x+y+2*z))
    @NLconstraint(m, x^2 + y^2 <= z)
    @NLconstraint(m, x^2 + y^2 <= -z+1)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, -9/4, tol = objective_tol)
    check_solution([x,y,z], [1/4, 1/4, 7/8], tol = primal_tol)
    
end

