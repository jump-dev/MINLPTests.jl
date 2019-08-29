function nlp_cvx_101_011(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET_LOCAL,
        primal_target = PRIMAL_TARGET_LOCAL)
    m = Model(optimizer)
    
    @variable(m, -2 <= x <= 2)
    @variable(m, -2 <= y <= 2)
    
    @objective(m, Min, -x)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, -1, tol = objective_tol)
    check_solution([x,y], [1, 0], tol = primal_tol)
    
end

