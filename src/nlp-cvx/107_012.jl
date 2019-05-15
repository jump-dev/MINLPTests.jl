function nlp_cvx_107_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x, start = 1.5)
    @variable(m, y, start = 0.5)
    
    @objective(m, Min, (x-1.0)^2 + (y-1.0)^2)
    @NLconstraint(m, x^2 + y^2 <= 1)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 0.17157287363083387, tol = objective_tol)
    check_solution([x,y], [1/sqrt(2), 1/sqrt(2)], tol = primal_tol)
    
end

