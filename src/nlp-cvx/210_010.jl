function nlp_cvx_210_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    # Test Goals:
    # - convex objective
    # - convex quadratic constraint
    # Variants
    #   010 - no binding constraints
    #   011 - binding constraint
    #   012 - binding constraint, different starting point
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    @variable(m, z)
    
    @objective(m, Min, (x-0.5)^2 + (y-0.5)^2 + (z-0.5)^2)
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 0.0, tol = objective_tol)
    check_solution([x,y,z], [1/2, 1/2, 1/2], tol = primal_tol)
    
end

