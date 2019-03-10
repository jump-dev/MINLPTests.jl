function nlp_mi_003_016(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - objective with offset
    
    m = Model(solver = optimizer)
    
    @variable(m, 0 <= x <= 4, Int)
    @variable(m, 0 <= y <= 4, Int)
    
    @objective(m, Max, x + pi)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 6.141592682680717, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

