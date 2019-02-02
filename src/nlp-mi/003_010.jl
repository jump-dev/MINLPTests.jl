function nlp_mi_003_010(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - none have start values
    # - non-linear objective and non-linear constraints
    # - maximization objective
    # - functions sqrt, sin
    # - integer variables
    
    m = Model(optimizer)
    
    @variable(m, x, Int)
    @variable(m, y, Int)
    
    @NLobjective(m, Max, sqrt(x+0.1))
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 1.7606816937762844, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

