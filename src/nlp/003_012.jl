function nlp_003_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - linear objective and non-linear constraints
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Max, x)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 3.4028339567042485, tol = objective_tol)
    check_solution([x,y], [3.4028339561149266, 2.0667085252601867], tol = primal_tol)
    
end

