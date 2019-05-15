function nlp_mi_002_010(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - all have start values
    # - non-linear constraints without objective
    # - functions log
    # - binary variable
    
    m = Model(optimizer)
    
    @variable(m, x >= 0.9, start=  1, Int)
    @variable(m, y, start= -1.12, Bin)
    
    @NLconstraint(m, y <= log(x) - 0.1)
    @NLconstraint(m, x <= cos(y)^2+1.5)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 0.0, tol = objective_tol)
    check_solution([x,y], [2, 0], tol = primal_tol)
    
end

