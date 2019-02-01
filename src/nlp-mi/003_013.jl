function nlp_mi_003_013(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective as NLobjective and non-linear constraints
    
    m = Model(solver=solver)
    
    @variable(m, x, Int)
    @variable(m, y, Int)
    
    @NLobjective(m, Max, x)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 3, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

