function nlp_mi_003_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - none have start values
    # - non-linear objective and non-linear constraints
    # - maximization objective
    # - variable bounds
    # - functions sqrt, sin
    # - integer variables
    
    m = Model(solver = optimizer)
    
    @variable(m, 0 <= x <= 4, Int)
    @variable(m, 0 <= y <= 4, Int)
    
    @NLobjective(m, Max, sqrt(x+0.1))
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.7606816937762844, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

