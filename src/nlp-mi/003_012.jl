function nlp_mi_003_012(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - linear objective and non-linear constraints
    
    m = Model(optimizer)
    
    @variable(m, x, Int)
    @variable(m, y, Int)
    
    @objective(m, Max, x)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 3, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

