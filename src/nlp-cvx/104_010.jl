function nlp_cvx_104_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - redundant nonlinear constraint (feasible set is inside the circle constraint)
    # Variants
    #   010 - redundant constraint
    
    m = Model(solver = optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    @NLconstraint(m, x^2 + (y-0.5)^2 <= 1.0)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1/sqrt(2), tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/2], tol = primal_tol)
    
end

