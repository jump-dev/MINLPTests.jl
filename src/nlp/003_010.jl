function nlp_003_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - none have start values
    # - non-linear objective and non-linear constraints
    # - maximization objective
    # - variable bounds
    # - functions sqrt, sin
    
    m = Model(solver = optimizer)
    
    @variable(m, 0 <= x <= 4)
    @variable(m, 0 <= y <= 4)
    
    @NLobjective(m, Max, sqrt(x+0.1))
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, 1.8320787790166984, tol = objective_tol)
    check_solution([x,y], [3.2565126525233166, 2.013148549981813], tol = primal_tol)
    
end

