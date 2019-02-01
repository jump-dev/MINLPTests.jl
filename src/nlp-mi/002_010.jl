function nlp_mi_002_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - all have start values
    # - non-linear constraints without objective
    # - functions log
    # - binary variable
    
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0.9, start=  1, Int)
    @variable(m, y, start= -1.12, Bin)
    
    @NLconstraint(m, y <= log(x) - 0.1)
    @NLconstraint(m, x <= cos(y)^2+1.5)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 0.0, tol = objective_tol)
    check_solution([x,y], [2, 0], tol = primal_tol)
    
end

