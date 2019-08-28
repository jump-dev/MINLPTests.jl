function nlp_003_014(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    # Test Goals:
    # - quadratic objective and non-linear constraints
    
    m = Model(optimizer)
    
    @variable(m, 0 <= x <= 4)
    @variable(m, 0 <= y <= 4)
    
    @objective(m, Max, x^2 + y)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 12.618023354784961, tol = objective_tol)
    check_solution([x,y], [3.2565126525233166, 2.013148549981813], tol = primal_tol)
    
end

