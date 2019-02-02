function nlp_cvx_001_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, (x-1)^2 + (y-2)^2)
    @constraint(m, x+y <= 5)
    @constraint(m, 2*x-y <= 3)
    @constraint(m, 3*x+9*y >= -10)
    @constraint(m, 10*x-y >= -20)
    @constraint(m, -x+2*y <= 8)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.0, tol = objective_tol)
    check_solution([x,y], [1.0, 2.0], tol = primal_tol)
    
end

