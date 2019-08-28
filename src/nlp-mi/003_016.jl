function nlp_mi_003_016(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    # Test Goals:
    # - objective with offset
    
    m = Model(optimizer)
    
    @variable(m, 0 <= x <= 4, Int)
    @variable(m, 0 <= y <= 4, Int)
    
    @objective(m, Max, x + pi)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 6.141592682680717, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)
    
end

