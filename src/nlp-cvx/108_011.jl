function nlp_cvx_108_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0)
    @variable(m, y >= 0)
    
    @objective(m, Min, (x-3.0)^2 + y^2)
    @NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
    @NLconstraint(m, y^2 <= -x+2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.5240966871955863, tol = objective_tol)
    check_solution([x,y], [1.8344380292075626, 0.40689308108892147], tol = primal_tol)
    
end

