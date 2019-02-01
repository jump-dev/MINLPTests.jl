function nlp_cvx_106_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, -3 <= x <= 3)
    @variable(m, -1 <= y <= 1)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, sin(-x-1.0) + x/2 + 0.5 <= y)
    @NLconstraint(m, cos(x-0.5)+ x/4 - 0.5 >= y)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -0.7868226265935826, tol = objective_tol)
    check_solution([x,y], [-0.5955231764562057, -0.1912994501373769], tol = primal_tol)
    
end

