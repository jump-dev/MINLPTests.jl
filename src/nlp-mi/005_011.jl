function nlp_mi_005_011(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - function \
    
    m = Model(solver = optimizer)
    
    @variable(m, x >= 0, Int)
    @variable(m, y >= 0)
    
    @objective(m, Min, x + y)
    @NLconstraint(m, y >= (x+0.1)\1 - 0.5)
    @NLconstraint(m, x >= y^(-2) - 0.5)
    @NLconstraint(m, (x+y+0.1) \ 4 >= 1)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.8164965727459055, tol = objective_tol)
    check_solution([x,y], [1, 0.816496581496872], tol = primal_tol)
    
end

