function nlp_003_015(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - quadratic objective as NLobjective and non-linear constraints
    
    m = Model(solver=solver)
    
    @variable(m, x)
    @variable(m, y)
    
    @NLobjective(m, Max, x^2 + y)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 13.645987504086483, tol = objective_tol)
    check_solution([x,y], [3.4028339561149266, 2.0667085252601867], tol = primal_tol)
    
end

