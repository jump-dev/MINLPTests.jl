function nlp_003_011(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - non-linear objective and non-linear constraints
    # - NLobjective with offset
    
    m = Model(solver = optimizer)
    
    @variable(m, 0 <= x <= 4)
    @variable(m, 0 <= y <= 4)
    
    @NLobjective(m, Max, sqrt(x+0.1) + pi)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 4.973671432569242, tol = objective_tol)
    check_solution([x,y], [3.2565126525233166, 2.013148549981813], tol = primal_tol)
    
end

