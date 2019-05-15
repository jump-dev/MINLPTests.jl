function nlp_cvx_102_013(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, x^2+y^2)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    @constraint(m, x + y >= 1.2)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 0.72, tol = objective_tol)
    check_solution([x,y], [0.6, 0.6], tol = primal_tol)
    
end

