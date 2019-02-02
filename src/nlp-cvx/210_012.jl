function nlp_cvx_210_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED, 
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)
    
    @variable(m, x, start=1.5)
    @variable(m, y, start=1.0)
    @variable(m, z, start=0.5)
    
    @objective(m, Min, (x-1.0)^2 + (y-1.0)^2 + (z-1.0)^2)
    @NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m, termination_target, primal_target)
    check_objective(m, 0.535898380052066, tol = objective_tol)
    check_solution([x,y,z], [1/sqrt(3), 1/sqrt(3), 1/sqrt(3)], tol = primal_tol)
    
end

