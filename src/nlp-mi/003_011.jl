function nlp_mi_003_011(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - non-linear objective and non-linear constraints
    # - NLobjective with offset
    
    m = Model(optimizer)
    
    @variable(m, x, Int)
    @variable(m, y, Int)
    
    @NLobjective(m, Max, sqrt(x+0.1) + pi)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 4.9022743473660775, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

