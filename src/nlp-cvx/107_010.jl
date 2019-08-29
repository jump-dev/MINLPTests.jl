function nlp_cvx_107_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    # Test Goals:
    # - convex objective
    # - single simple constraint
    # Variants
    #   010 - no binding constraints
    #   011 - binding constraint
    #   012 - binding constraint, different starting point
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, (x-0.5)^2 + (y-0.5)^2)
    @NLconstraint(m, x^2 + y^2 <= 1)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 0, tol = objective_tol)
    check_solution([x,y], [1/2, 1/2], tol = primal_tol)
    
end

