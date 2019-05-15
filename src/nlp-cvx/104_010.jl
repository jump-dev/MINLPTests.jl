function nlp_cvx_104_010(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - redundant nonlinear constraint (feasible set is inside the circle constraint)
    # Variants
    #   010 - redundant constraint
    
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 <= y)
    @NLconstraint(m, -x^2 + 1 >= y)
    @NLconstraint(m, x^2 + (y-0.5)^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, -1/sqrt(2), tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/2], tol = primal_tol)
    
end

