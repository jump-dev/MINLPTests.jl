function nlp_003_016(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - objective with offset
    
    m = Model(solver = optimizer)
    
    @variable(m, 0 <= x <= 4)
    @variable(m, 0 <= y <= 4)
    
    @objective(m, Max, x + pi)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 6.398105319414242, tol = objective_tol)
    check_solution([x,y], [3.2565126525233166, 2.013148549981813], tol = primal_tol)
    
end

